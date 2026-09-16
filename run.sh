#!/usr/bin/env bash
set -euo pipefail

args=("")

if [[ -n "$ELEVON_PROJECT" ]]; then
	args+=("--project $ELEVON_PROJECT")
fi

if [[ -n "$ELEVON_CONFIG" ]]; then
	args+=("--config $ELEVON_CONFIG")
fi

args+=("$ELEVON_COMMAND")

if [[ -n "$ELEVON_APP" ]]; then
	args+=("--app $ELEVON_APP")
fi

"$RUNNER_TEMP/elevon-deploy" "${args[@]}"
