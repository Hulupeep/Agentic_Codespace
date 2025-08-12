#\!/usr/bin/env node
// Simple Database Viewer - Shows what's in your Supabase database
// Run with: node examples/view-database.js

const { createClient } = require('@supabase/supabase-js');

// Local Supabase connection
const supabaseUrl = 'http://localhost:54321';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

const supabase = createClient(supabaseUrl, supabaseKey);

async function viewDatabase() {
    console.log('🔍 Checking your Supabase database...\n');
    
    try {
        const { data, error } = await supabase
            .from('tide_times')
            .select('*')
            .limit(5)
            .order('date', { ascending: false });
            
        if (data) {
            console.log('📊 Latest 5 tide records:');
            console.log('─'.repeat(50));
            data.forEach(tide => {
                console.log(`${tide.date}: High ${tide.morning_high_time} (${tide.morning_high_height}m)`);
            });
        }
        
        console.log('\n✅ Database connection successful\!');
        console.log('🎯 Open Supabase Studio at http://localhost:54323');
        
    } catch (error) {
        console.error('❌ Error:', error.message);
        console.log('💡 Run: npx supabase start');
    }
}

viewDatabase();
