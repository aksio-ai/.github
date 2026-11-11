#!/bin/sh
# Fails when a tracked file, a commit message of the change, or the pull request
# title or body carries an authorship line for an assistant. The pattern is scoped
# to the vendor and product names in attribution-pattern.txt; it does not match the
# bare words "generated with".
# Inputs (optional, set by the workflow): BASE_SHA, PR_TITLE, PR_BODY.
set -u
cd "$(git rev-parse --show-toplevel)" || exit 2
pattern=.github/checks/attribution-pattern.txt
fail=0

if git grep -nIiE -f "$pattern" -- . ":(exclude)$pattern"; then
  echo "attribution: authorship line found in the files above" >&2
  fail=1
fi

if [ -n "${BASE_SHA:-}" ]; then
  range="$BASE_SHA..HEAD"
else
  range=HEAD
fi
if git rev-parse -q --verify HEAD > /dev/null && git log --format=%B "$range" | grep -niE -f "$pattern"; then
  echo "attribution: authorship line found in a commit message ($range)" >&2
  fail=1
fi

if printf '%s\n%s\n' "${PR_TITLE:-}" "${PR_BODY:-}" | grep -niE -f "$pattern"; then
  echo "attribution: authorship line found in the pull request title or body" >&2
  fail=1
fi

[ "$fail" -eq 0 ] && echo "attribution: ok"
exit "$fail"
