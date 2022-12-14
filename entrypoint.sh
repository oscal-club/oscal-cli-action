#!/bin/bash -l
set -uo pipefail

# Enable optional debug output
if [ "${INPUT_DEBUG}" = true ]; then
  echo "Debug output enabled"
  set -x
fi

OSCALCLI_TMP="$(mktemp)"
GITHUB_WORKFLOW_URL="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}?check_suite_focus=true"

ARGS="${INPUT_ARGS}"

# Execute oscal-cli
eval oscal-cli ${ARGS} 
exit_code=$?

if [ ! -f "${OSCALCLI_TMP}" ]; then
    echo "No output. Check pipeline run to see if oscal-cli panicked." > "${OSCALCLI_TMP}"
fi

# Output to console
cat "${OSCALCLI_TMP}"
echo

# Pass oscal-cli exit code to next step
echo "oscalcli_exit_code=$exit_code" >> $GITHUB_ENV
