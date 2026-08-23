#!/usr/bin/env zsh
set -euo pipefail

script_dir="${0:A:h}"
bridge_dir="${script_dir:h}"
bin_dir="$bridge_dir/bin"
fixture_dir="$script_dir/fixtures"

test_root="$(mktemp -d "${TMPDIR:-/tmp}/cursor-bridge-tests.XXXXXX")"
trap 'rm -rf "$test_root"' EXIT

fake_bin="$test_root/bin"
mkdir -p "$fake_bin"
cp "$fixture_dir/cursor-agent" "$fake_bin/cursor-agent"
chmod +x "$fake_bin/cursor-agent"

export PATH="$fake_bin:$PATH"

failures=0

fail() {
  print -u2 -- "FAIL: $1"
  failures=$((failures + 1))
}

assert_eq() {
  local expected="$1"
  local actual="$2"
  local label="$3"
  if [[ "$actual" != "$expected" ]]; then
    fail "$label (expected '$expected', got '$actual')"
  fi
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"
  if [[ "$haystack" != *"$needle"* ]]; then
    fail "$label (missing '$needle')"
  fi
}

assert_not_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    fail "$label (unexpected '$needle')"
  fi
}

run_wrapper() {
  local wrapper="$1"
  local scenario="$2"
  shift 2

  local case_dir
  case_dir="$(mktemp -d "$test_root/case.XXXXXX")"
  mkdir -p "$case_dir/state" "$case_dir/workspace"

  export FAKE_CURSOR_STATE_DIR="$case_dir/state"
  export FAKE_CURSOR_SCENARIO="$scenario"

  set +e
  (
    cd "$case_dir/workspace"
    CODEX_CURSOR_STATUS_FILE="$case_dir/events" "$bin_dir/$wrapper" "$@"
  ) >"$case_dir/stdout" 2>"$case_dir/stderr"
  RUN_STATUS=$?
  set -e

  RUN_STDOUT="$(<"$case_dir/stdout")"
  RUN_STDERR="$(<"$case_dir/stderr")"
  if [[ -f "$case_dir/state/calls" ]]; then
    RUN_CALLS="$(<"$case_dir/state/calls")"
  else
    RUN_CALLS="0"
  fi
  if [[ -f "$case_dir/state/args" ]]; then
    RUN_ARGS="$(<"$case_dir/state/args")"
  else
    RUN_ARGS=""
  fi
  if [[ -f "$case_dir/events" ]]; then
    RUN_EVENTS="$(<"$case_dir/events")"
  else
    RUN_EVENTS=""
  fi
}

run_wrapper_async() {
  local wrapper="$1"
  local scenario="$2"
  shift 2

  RUN_CASE_DIR="$(mktemp -d "$test_root/case.XXXXXX")"
  mkdir -p "$RUN_CASE_DIR/state" "$RUN_CASE_DIR/workspace"

  (
    cd "$RUN_CASE_DIR/workspace"
    FAKE_CURSOR_STATE_DIR="$RUN_CASE_DIR/state" \
      FAKE_CURSOR_SCENARIO="$scenario" \
      CODEX_CURSOR_STATUS_FILE="$RUN_CASE_DIR/events" \
      "$bin_dir/$wrapper" "$@"
  ) >"$RUN_CASE_DIR/stdout" 2>"$RUN_CASE_DIR/stderr" &
  RUN_WRAPPER_PID=$!
}

run_wrapper codex-cursor-ask success --model cursor-grok-4.6-high-fast "health check"
assert_eq "0" "$RUN_STATUS" "ask success status"
assert_eq "FAKE_OK" "$RUN_STDOUT" "ask success output"
assert_eq "1" "$RUN_CALLS" "ask success call count"
assert_contains "$RUN_STDERR" "Cursor call started" "ask reports immediate liveness"
assert_contains "$RUN_ARGS" "--output-format stream-json" "ask requests structured output"
assert_contains "$RUN_ARGS" "--mode ask" "ask passes ask mode"
assert_contains "$RUN_ARGS" "--model cursor-grok-4.6-high-fast" "ask passes model"
assert_contains "$RUN_ARGS" "--trust" "ask trusts selected workspace"
assert_contains "$RUN_ARGS" "--workspace" "ask passes workspace"
assert_contains "$RUN_EVENTS" "CODEX_CURSOR_EVENT state=started" "ask records a durable start event"
assert_contains "$RUN_EVENTS" "CODEX_CURSOR_EVENT state=succeeded" "ask records a durable success event"
assert_contains "$RUN_EVENTS" "max_seconds=none" "ask has no default deadline"

export CODEX_CURSOR_HEARTBEAT_SECONDS=1
run_wrapper codex-cursor-ask slow_success "wait for a slow response"
assert_eq "0" "$RUN_STATUS" "ask slow success status"
assert_eq "SLOW_FAKE_OK" "$RUN_STDOUT" "ask slow success output"
assert_contains "$RUN_STDERR" "CODEX_CURSOR_EVENT state=heartbeat" "ask reports periodic liveness"
unset CODEX_CURSOR_HEARTBEAT_SECONDS

export CODEX_CURSOR_HEARTBEAT_SECONDS=1
run_wrapper codex-cursor-ask stream_slow_success "surface a streaming Cursor activity summary"
assert_eq "0" "$RUN_STATUS" "ask stream success status"
assert_eq "STREAM_FAKE_OK" "$RUN_STDOUT" "ask stream success output"
assert_contains "$RUN_ARGS" "--output-format stream-json" "ask requests stream JSON"
assert_contains "$RUN_ARGS" "--stream-partial-output" "ask requests streamed activity"
assert_contains "$RUN_STDERR" "CODEX_CURSOR_EVENT state=activity" "ask reports compact stream activity"
assert_contains "$RUN_STDERR" "last_type=thinking" "ask classifies the last stream activity"
assert_not_contains "$RUN_STDERR" "private thought" "ask does not relay thinking text"
assert_not_contains "$RUN_EVENTS" "private thought" "ask does not persist thinking text"
unset CODEX_CURSOR_HEARTBEAT_SECONDS

export FAKE_CURSOR_DELAY_SECONDS=2
export CODEX_CURSOR_MAX_SECONDS=1
run_wrapper codex-cursor-ask slow_success "stop a hung Cursor call"
assert_eq "124" "$RUN_STATUS" "ask timed-out status"
assert_eq "1" "$RUN_CALLS" "ask timed-out call count"
assert_contains "$RUN_STDERR" "CODEX_CURSOR_EVENT state=timed_out" "ask reports a machine-readable timeout"
assert_contains "$RUN_STDERR" "exceeded configured maximum duration" "ask explains its terminal timeout"
unset CODEX_CURSOR_MAX_SECONDS
unset FAKE_CURSOR_DELAY_SECONDS

run_wrapper_async codex-cursor-ask slow_success "cancel an in-flight Cursor call"
for _ in {1..30}; do
  [[ -f "$RUN_CASE_DIR/state/agent_pid" ]] && break
  sleep 0.1
done
if [[ ! -f "$RUN_CASE_DIR/state/agent_pid" ]]; then
  fail "ask cancellation test did not start the fake Cursor process"
else
  RUN_AGENT_PID="$(<"$RUN_CASE_DIR/state/agent_pid")"
  kill -TERM "$RUN_WRAPPER_PID"
  set +e
  wait "$RUN_WRAPPER_PID"
  RUN_STATUS=$?
  set -e
  assert_eq "143" "$RUN_STATUS" "ask interrupted status"
  sleep 1
  if kill -0 "$RUN_AGENT_PID" 2>/dev/null; then
    fail "ask cancellation stops the child Cursor process"
  fi
  RUN_STDERR="$(<"$RUN_CASE_DIR/stderr")"
  RUN_EVENTS="$(<"$RUN_CASE_DIR/events")"
  assert_contains "$RUN_STDERR" "CODEX_CURSOR_EVENT state=cancelled" "ask reports cancellation"
  assert_contains "$RUN_EVENTS" "CODEX_CURSOR_EVENT state=cancelled" "ask persists cancellation"
fi

export CODEX_CURSOR_MODEL="glm-5.2-high"
run_wrapper codex-cursor-ask success "use the environment model"
assert_contains "$RUN_ARGS" "--model glm-5.2-high" "ask honors environment model"

run_wrapper codex-cursor-ask success --model cursor-grok-4.6-high-fast "override the environment model"
assert_contains "$RUN_ARGS" "--model cursor-grok-4.6-high-fast" "per-call model overrides environment"
assert_not_contains "$RUN_ARGS" "--model glm-5.2-high" "environment model is not also forwarded"
unset CODEX_CURSOR_MODEL

run_wrapper codex-cursor-ask transient_then_success "retry a transient failure"
assert_eq "0" "$RUN_STATUS" "ask transient recovery status"
assert_eq "RECOVERED" "$RUN_STDOUT" "ask transient recovery output"
assert_eq "2" "$RUN_CALLS" "ask transient retry count"
assert_contains "$RUN_STDERR" "retrying once" "ask transient retry notice"

run_wrapper codex-cursor-plan empty_then_success "retry an empty result"
assert_eq "0" "$RUN_STATUS" "plan empty recovery status"
assert_eq "RECOVERED_FROM_EMPTY" "$RUN_STDOUT" "plan empty recovery output"
assert_eq "2" "$RUN_CALLS" "plan empty retry count"
assert_contains "$RUN_STDERR" "empty result" "plan empty diagnostic"

run_wrapper codex-cursor-ask empty "report terminal empty evidence"
assert_eq "70" "$RUN_STATUS" "ask exhausted empty status"
assert_eq "2" "$RUN_CALLS" "ask exhausted empty retry count"
assert_contains "$RUN_STDERR" "model=default" "ask failure reports model"
assert_contains "$RUN_STDERR" "status=0" "ask failure reports terminal status"
assert_contains "$RUN_STDERR" "stdout_bytes=" "ask failure reports stdout byte count"
assert_contains "$RUN_STDERR" "stderr_bytes=" "ask failure reports stderr byte count"

run_wrapper codex-cursor-ask invalid_json_then_success "retry invalid JSON"
assert_eq "0" "$RUN_STATUS" "ask invalid JSON recovery status"
assert_eq "RECOVERED_FROM_INVALID_JSON" "$RUN_STDOUT" "ask invalid JSON recovery output"
assert_eq "2" "$RUN_CALLS" "ask invalid JSON retry count"

run_wrapper codex-cursor-ask auth_failure "do not retry auth failures"
assert_eq "1" "$RUN_STATUS" "ask auth failure status"
assert_eq "1" "$RUN_CALLS" "ask auth failure call count"
assert_contains "$RUN_STDERR" "Authentication failed" "ask preserves auth error"
assert_not_contains "$RUN_STDERR" "retrying once" "ask does not retry auth failure"

run_wrapper codex-cursor-ask keychain_failure "classify restricted Keychain access"
assert_eq "139" "$RUN_STATUS" "ask Keychain failure status"
assert_eq "1" "$RUN_CALLS" "ask Keychain failure call count"
assert_contains "$RUN_STDERR" "SecItemCopyMatching failed -50" "ask preserves Keychain error"
assert_contains "$RUN_STDERR" "rerun the same command with host access" "ask explains Keychain repair"
assert_not_contains "$RUN_STDERR" "retrying once" "ask does not retry Keychain failure"

run_wrapper codex-cursor-plan structured_auth_failure "do not retry structured auth failures"
assert_eq "70" "$RUN_STATUS" "plan structured auth failure status"
assert_eq "1" "$RUN_CALLS" "plan structured auth failure call count"
assert_contains "$RUN_STDERR" "Authentication required" "plan preserves structured auth error"
assert_not_contains "$RUN_STDERR" "retrying once" "plan does not retry structured auth failure"

run_wrapper codex-cursor-ask structured_nonzero_auth_failure "preserve structured nonzero auth failures"
assert_eq "1" "$RUN_STATUS" "ask structured nonzero auth failure status"
assert_eq "1" "$RUN_CALLS" "ask structured nonzero auth failure call count"
assert_contains "$RUN_STDERR" "Credentials expired" "ask preserves structured nonzero error"
assert_not_contains "$RUN_STDERR" "retrying once" "ask does not retry structured nonzero auth failure"

run_wrapper codex-cursor-ask permission_failure "do not retry permission failures"
assert_eq "1" "$RUN_STATUS" "ask permission failure status"
assert_eq "1" "$RUN_CALLS" "ask permission failure call count"
assert_not_contains "$RUN_STDERR" "retrying once" "ask does not retry permission failure"

run_wrapper codex-cursor-plan invalid_model_failure "do not retry invalid model failures"
assert_eq "1" "$RUN_STATUS" "plan invalid model failure status"
assert_eq "1" "$RUN_CALLS" "plan invalid model failure call count"
assert_not_contains "$RUN_STDERR" "retrying once" "plan does not retry invalid model failure"

run_wrapper codex-cursor-impl empty "implementation with empty result"
assert_eq "70" "$RUN_STATUS" "implementation empty status"
assert_eq "1" "$RUN_CALLS" "implementation empty call count"
assert_contains "$RUN_STDERR" "session_id=session-1" "implementation reports session id"
assert_contains "$RUN_STDERR" "request_id=request-1" "implementation reports request id"
assert_contains "$RUN_STDERR" "stdout_bytes=" "implementation reports stdout byte count"
assert_contains "$RUN_STDERR" "stderr_bytes=" "implementation reports stderr byte count"
assert_contains "$RUN_STDERR" "inspect the workspace diff" "implementation warns before retry"
assert_not_contains "$RUN_STDERR" "retrying once" "implementation never retries blindly"
assert_not_contains "$RUN_ARGS" "--mode" "implementation does not force read-only mode"

run_wrapper codex-cursor-impl success "implementation success"
assert_eq "0" "$RUN_STATUS" "implementation success status"
assert_eq "FAKE_OK" "$RUN_STDOUT" "implementation success output"
assert_eq "1" "$RUN_CALLS" "implementation success call count"

if [[ "$failures" -gt 0 ]]; then
  print -u2 -- "$failures test assertion(s) failed"
  exit 1
fi

print -- "All Cursor bridge tests passed"
