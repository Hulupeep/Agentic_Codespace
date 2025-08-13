#!/bin/bash
# Quick script to start Supabase if it's not running

echo "🔍 Checking Supabase status..."

if npx supabase status 2>/dev/null | grep -q "supabase local development setup"; then
    echo "✅ Supabase is already running!"
    echo "📊 Open Supabase Studio: http://localhost:54323"
else
    echo "🚀 Starting Supabase (this takes 30-60 seconds)..."
    npx supabase start
    
    echo ""
    echo "✅ Supabase started successfully!"
    echo "📊 Supabase Studio: http://localhost:54323"
    echo ""
    echo "🌊 Importing tide data..."
    node import-tide-data.js 2>/dev/null || echo "Run 'node import-tide-data.js' manually if needed"
fi

echo ""
echo "💡 To view your data:"
echo "   1. Click the Ports tab in VS Code"
echo "   2. Find port 54323 (Supabase Studio)"
echo "   3. Click the globe icon to open in browser"
echo "   4. Browse the tide_times table"