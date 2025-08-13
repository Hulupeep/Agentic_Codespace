#!/bin/bash
# Final setup - Start Supabase properly and install Claude

echo "🚀 Setting up Agentic Codespace..."
echo "═══════════════════════════════════════════════════════════"

# Install Claude Code
echo "📦 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code --silent 2>/dev/null || true

# Start Supabase FIRST (important!)
echo "🗄️ Starting Supabase database (takes 30-60 seconds)..."
cd /workspaces/Agentic_Codespace

# Start Supabase and wait for it
npx supabase start &
SUPABASE_PID=$!

# Wait for Supabase to be ready (check every 5 seconds)
for i in {1..20}; do
    if npx supabase status 2>/dev/null | grep -q "supabase local development setup"; then
        echo "✅ Supabase is running!"
        break
    fi
    echo "   Waiting for Supabase to start... ($i/20)"
    sleep 5
done

# Import tide data after Supabase is ready
echo "🌊 Importing tide data..."
if [ -f "import-tide-data.js" ]; then
    node import-tide-data.js 2>/dev/null || echo "   Tide data will be imported later"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "    ✅ READY! Your Agentic Codespace is set up"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📊 Supabase Studio: http://localhost:54323"
echo "   (If not working, run: npx supabase start)"
echo ""
echo "🤖 Claude Code: Ready to use!"
echo "   Try: claude 'show me this project'"
echo ""
echo "🔄 Claude Flow: Pre-configured"  
echo "   Try: npx claude-flow sparc modes"
echo ""

# Mark as complete
touch /tmp/setup-complete