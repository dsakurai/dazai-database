#!/usr/bin/env bash

set -euo pipefail

Q="戦争に語った部分を教えてください。"
llm similar dazai_works -n 5 -d out/aozora-rag.db -c "$Q" \
  | jq -s '.[0:5] | map("【\(.id)】\n" + (.content // "")) | join("\n\n")'
