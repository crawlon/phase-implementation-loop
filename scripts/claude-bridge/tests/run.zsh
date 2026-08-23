#!/usr/bin/env zsh
set -euo pipefail

script_dir="${0:A:h}"
bridge_dir="${script_dir:h}"
bin_dir="$bridge_dir/bin"
fixture_dir="$script_dir/fixtures"

test_root="$(mktemp -d "${TMPDIR:-/tmp}/claude-bridge-tests.XXXXXX")"
trap 'rm -rf "$test_root"' EXIT

fake_bin="$test_root/bin"
mkdir -p "$fake_bin"
cp "$fixture_dir/claude" "$fake_bin/claude"
chmod +x "$fake_bin/claude"
export PATH="$fake_bin:$PATH"

failures=0

fail() {
  print -u2 -- "FAIL: $1"
  failures=$((failures + 1))
}

assert_eq() {
  [[ "$1" == "$2" ]] || fail "$3 (expected '$1', got '$2')"
}

assert_contains() {
  [[ "$1" == *"$2"* ]] || fail "$3 (missing '$2')"
}

assert_not_contains() {
  [[ "$1" != *"$2"* ]] || fail "$3 (unexpected '$2')"
}

run_wrapper() {
  local scenario="$1"
  shift
  local case_dir
  case_dir="$(mktemp -d "$test_root/case.XXXXXX")"
  mkdir -p "$case_dir/state" "$case_dir/workspace"

  set +e
  (
    cd "$case_dir/workspace"
    FAKE_CLAUDE_STATE_DIR="$case_dir/state" \
      FAKE_CLAUDE_SCENARIO="$scenario" \
      CODEX_CLAUDE_STATUS_FILE="$case_dir/events" \
      "$bin_dir/codex-claude-ask" "$@"
  ) >"$case_dir/stdout" 2>"$case_dir/stderr"
  RUN_STATUS=$?
  set -e

  RUN_STDOUT="$(<"$case_dir/stdout")"
  RUN_STDERR="$(<"$case_dir/stderr")"
  RUN_ARGS=""
  RUN_EVENTS=""
  if [[ -f "$case_dir/state/args" ]]; then
    RUN_ARGS="$(<"$case_dir/state/args")"
  fi
  if [[ -f "$case_dir/events" ]]; then
    RUN_EVENTS="$(<"$case_dir/events")"
  fi
}

run_wrapper_async() {
  local scenario="$1"
  shift
  RUN_CASE_DIR="$(mktemp -d "$test_root/case.XXXXXX")"
  mkdir -p "$RUN_CASE_DIR/state" "$RUN_CASE_DIR/workspace"

  (
    cd "$RUN_CASE_DIR/workspace"
    FAKE_CLAUDE_STATE_DIR="$RUN_CASE_DIR/state" \
      FAKE_CLAUDE_SCENARIO="$scenario" \
      CODEX_CLAUDE_STATUS_FILE="$RUN_CASE_DIR/events" \
      "$bin_dir/codex-claude-ask" "$@"
  ) >"$RUN_CASE_DIR/stdout" 2>"$RUN_CASE_DIR/stderr" &
  RUN_WRAPPER_PID=$!
}

run_wrapper success --model haiku "health check"
assert_eq "0" "$RUN_STATUS" "success status"
assert_eq "CLAUDE_FAKE_OK" "$RUN_STDOUT" "success output"
assert_contains "$RUN_ARGS" "--output-format stream-json" "uses stream JSON"
assert_contains "$RUN_ARGS" "--verbose" "uses Claude required verbose mode"
assert_contains "$RUN_ARGS" "--include-partial-messages" "receives stream activity"
assert_contains "$RUN_EVENTS" "CODEX_CLAUDE_EVENT state=started" "records start"
assert_contains "$RUN_EVENTS" "CODEX_CLAUDE_EVENT state=succeeded" "records success"
assert_contains "$RUN_EVENTS" "max_seconds=none" "has no default deadline"

export CODEX_CLAUDE_HEARTBEAT_SECONDS=1
run_wrapper stream_slow_success "stream activity"
assert_eq "0" "$RUN_STATUS" "stream success status"
assert_eq "STREAM_CLAUDE_FAKE_OK" "$RUN_STDOUT" "stream success output"
assert_contains "$RUN_STDERR" "CODEX_CLAUDE_EVENT state=activity" "reports compact stream activity"
assert_contains "$RUN_STDERR" "last_type=stream_event" "classifies stream event"
assert_contains "$RUN_STDERR" "last_subtype=content_block_delta" "classifies nested event"
assert_not_contains "$RUN_STDERR" "private Claude text" "does not relay partial text"
assert_not_contains "$RUN_EVENTS" "private Claude text" "does not persist partial text"
unset CODEX_CLAUDE_HEARTBEAT_SECONDS

export CODEX_CLAUDE_HEARTBEAT_SECONDS=1
run_wrapper slow_success "idle activity"
assert_eq "0" "$RUN_STATUS" "idle success status"
assert_contains "$RUN_STDERR" "CODEX_CLAUDE_EVENT state=heartbeat" "reports idle heartbeat"
unset CODEX_CLAUDE_HEARTBEAT_SECONDS

export FAKE_CLAUDE_DELAY_SECONDS=2
export CODEX_CLAUDE_MAX_SECONDS=1
run_wrapper slow_success "timed activity"
assert_eq "124" "$RUN_STATUS" "timeout status"
assert_contains "$RUN_STDERR" "CODEX_CLAUDE_EVENT state=timed_out" "reports timeout"
unset CODEX_CLAUDE_MAX_SECONDS
unset FAKE_CLAUDE_DELAY_SECONDS

run_wrapper_async slow_success "cancel an in-flight Claude call"
for _ in {1..30}; do
  [[ -f "$RUN_CASE_DIR/state/agent_pid" ]] && break
  sleep 0.1
done
if [[ ! -f "$RUN_CASE_DIR/state/agent_pid" ]]; then
  fail "cancellation test did not start the fake Claude process"
else
  RUN_AGENT_PID="$(<"$RUN_CASE_DIR/state/agent_pid")"
  kill -TERM "$RUN_WRAPPER_PID"
  set +e
  wait "$RUN_WRAPPER_PID"
  RUN_STATUS=$?
  set -e
  assert_eq "143" "$RUN_STATUS" "interrupted status"
  sleep 1
  if kill -0 "$RUN_AGENT_PID" 2>/dev/null; then
    fail "cancellation stops the child Claude process"
  fi
  RUN_STDERR="$(<"$RUN_CASE_DIR/stderr")"
  RUN_EVENTS="$(<"$RUN_CASE_DIR/events")"
  assert_contains "$RUN_STDERR" "CODEX_CLAUDE_EVENT state=cancelled" "reports cancellation"
  assert_contains "$RUN_EVENTS" "CODEX_CLAUDE_EVENT state=cancelled" "persists cancellation"
fi

run_wrapper empty "empty result"
assert_eq "70" "$RUN_STATUS" "empty terminal result status"
assert_contains "$RUN_STDERR" "empty result" "reports empty result"

if [[ "$failures" -gt 0 ]]; then
  print -u2 -- "$failures test assertion(s) failed"
  exit 1
fi

print -- "All Claude bridge tests passed"
