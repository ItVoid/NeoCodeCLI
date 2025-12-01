#!/usr/bin/sh
set -e

# === CONFIG ===
NODE_BIN="/slc/gad/alsantki/node-v22.17.0-linux-x64/bin/node"
OPENAI_BASE_URL="http://xgpc033:8000/v1"
OPENAI_API_KEY="1234"
OPENAI_MODEL="/fseis/gad/llms/transformers/models--Qwen--Qwen3-Coder-30B-A3B-Instruct/snapshots/573fa3901e5799703b1e60825b0ec024a4c0f1d3/"
# ===

mkdir -p "$HOME/.neocodecli"

#1. Disable telemetry
cat > "$HOME/.neocodecli/settings.json" <<'JSON'
{
  "usageStatisticsEnabled": false,
  "telemetry": {
    "enabled": false
  },
  "selectedAuthType": "openai",
  "enableOpenAILogging": false
}
JSON

# 2. Append envs tp ~/.cshrc (only once)
CSHRC="$HOME/.cshrc"
grep -q 'OPENAI_BASE_URL' "$CSHRC" 2>/dev/null || cat >> "$CSHRC" <<EOF

# >>> Qwen env vars >>>
setenv OPENAI_BASE_URL "$OPENAI_BASE_URL"
setenv OPENAI_API_KEY "$OPENAI_API_KEY"
setenv OPENAI_MODEL "$OPENAI_MODEL"
# <<< Qwen env vars <<<
EOF

grep -q "alias neocode" ~/.cshrc 2>/dev/null || echo "alias neocode 'node /slc/csd/psdm/scripts/qwen-code/scripts/start.js'" >> ~/.cshrc
echo "setenv PATH ${PATH}:${NODE_BIN}" >> ~/.cshrc

echo
echo "✅ NeoCode CLI setup complete."
echo "OpenAI APIs env variables added to: ~/.cshrc"
echo "Telemetry disabled: ~/.neocodecli/settings.json"