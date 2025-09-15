Q="著者が東京について語った部分を教えてください。"
CONTEXT=$(llm similar dazai_works -n 30 -d out/aozora-rag.db -c "$Q" \
  | jq -s '.[0:5] | map("【\(.id)】\n" + (.content // "")) | join("\n\n")')

echo "RAG:"
echo "$CONTEXT"
echo "\n\n"

# 2) Generate with an Ollama model
echo "llm:"
llm -m "llama3:latest" \
  --system "次の文脈を根拠に日本語で簡潔に答え、それが載っているhtmlファイル名を示してください：$CONTEXT" "質問: $Q"
