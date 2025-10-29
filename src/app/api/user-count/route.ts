import { NextResponse } from 'next/server'
import { supabase } from '../../../../utils/supabaseClient'

export async function GET() {
  // Handle case when Supabase is not initialized
  if (!supabase) {
    return NextResponse.json({ error: 'Supabase not initialized' }, { status: 500 })
  }

  try {
    const { count, error } = await supabase
      .from('profiles')
      .select('*', { count: 'exact', head: true })

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 })
    }

    return NextResponse.json({ count: count || 0 })
  } catch (error) {
    return NextResponse.json({ error: 'Failed to fetch user count' }, { status: 500 })
  }
}