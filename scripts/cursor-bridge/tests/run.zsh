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
    "$bin_dir/$wrapper" "$@"
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
}

run_wrapper codex-cursor-ask success --model cursor-grok-4.5-high "health check"
assert_eq "0" "$RUN_STATUS" "ask success status"
assert_eq "FAKE_OK" "$RUN_STDOUT" "ask success output"
assert_eq "1" "$RUN_CALLS" "ask success call count"
assert_contains "$RUN_STDERR" "Cursor call started" "ask reports immediate liveness"
assert_contains "$RUN_ARGS" "--output-format json" "ask requests structured output"
assert_contains "$RUN_ARGS" "--mode ask" "ask passes ask mode"
assert_contains "$RUN_ARGS" "--model cursor-grok-4.5-high" "ask passes model"
assert_contains "$RUN_ARGS" "--trust" "ask trusts selected workspace"
assert_contains "$RUN_ARGS" "--workspace" "ask passes workspace"

export CODEX_CURSOR_HEARTBEAT_SECONDS=1
run_wrapper codex-cursor-ask slow_success "wait for a slow response"
assert_eq "0" "$RUN_STATUS" "ask slow success status"
assert_eq "SLOW_FAKE_OK" "$RUN_STDOUT" "ask slow success output"
assert_contains "$RUN_STDERR" "Cursor is still running" "ask reports periodic liveness"
unset CODEX_CURSOR_HEARTBEAT_SECONDS

export CODEX_CURSOR_MODEL="glm-5.2-high"
run_wrapper codex-cursor-ask success "use the environment model"
assert_contains "$RUN_ARGS" "--model glm-5.2-high" "ask honors environment model"

run_wrapper codex-cursor-ask success --model cursor-grok-4.5-high "override the environment model"
assert_contains "$RUN_ARGS" "--model cursor-grok-4.5-high" "per-call model overrides environment"
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

run_wrapper codex-cursor-ask invalid_json_then_success "retry invalid JSON"
assert_eq "0" "$RUN_STATUS" "ask invalid JSON recovery status"
assert_eq "RECOVERED_FROM_INVALID_JSON" "$RUN_STDOUT" "ask invalid JSON recovery output"
assert_eq "2" "$RUN_CALLS" "ask invalid JSON retry count"

run_wrapper codex-cursor-ask auth_failure "do not retry auth failures"
assert_eq "1" "$RUN_STATUS" "ask auth failure status"
assert_eq "1" "$RUN_CALLS" "ask auth failure call count"
assert_contains "$RUN_STDERR" "Authentication failed" "ask preserves auth error"
assert_not_contains "$RUN_STDERR" "retrying once" "ask does not retry auth failure"

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
