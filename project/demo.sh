Q="太宰治の小説の中に、富士山を様々な場所から見た情景が羅列される技法はなかっただろうか。"
CONTEXT=$(llm similar dazai_works -d out/aozora-rag.db -c "$Q" \
  | jq -s '.[0:5] | map("【\(.id)】\n" + (.content // "")) | join("\n\n")')

# 2) Generate with an Ollama model
llm -m "llama3:latest" \
  --system "次の文脈を根拠に日本語で簡潔に答え、それが載っているhtmlファイル名を示してください。" \
  "$CONTEXT

質問: $Q"
