import { supabase } from './supabaseClient'
import { RealtimeChannel } from '@supabase/supabase-js'

// Subscribe to real-time changes in the photos table
export function subscribeToPhotos(callback: (payload: any) => void): RealtimeChannel | null {
  // Handle case when Supabase is not initialized
  if (!supabase) {
    console.log('Supabase not initialized, cannot subscribe to photos')
    return null
  }
  
  const subscription = supabase
    .channel('photos-changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'photos',
      },
      callback
    )
    .subscribe()

  return subscription
}

// Subscribe to real-time changes in the likes table
export function subscribeToLikes(callback: (payload: any) => void): RealtimeChannel | null {
  // Handle case when Supabase is not initialized
  if (!supabase) {
    console.log('Supabase not initialized, cannot subscribe to likes')
    return null
  }
  
  const subscription = supabase
    .channel('likes-changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'likes',
      },
      callback
    )
    .subscribe()

  return subscription
}