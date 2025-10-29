import { NextResponse } from 'next/server'
import { createClient } from '@supabase/supabase-js'

// Create a new supabase client for server-side operations
const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL || '',
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''
)

export async function GET() {
  try {
    const { count, error } = await supabase
      .from('profiles')
      .select('*', { count: 'exact', head: true })
    
    if (error) throw error
    
    return NextResponse.json({ count: count || 0 })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to fetch user count' }, { status: 500 })
  }
}