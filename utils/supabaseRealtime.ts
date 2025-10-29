import { supabase } from './supabaseClient'

// Subscribe to real-time changes in the photos table
export function subscribeToPhotos(callback: (payload: any) => void) {
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
export function subscribeToLikes(callback: (payload: any) => void) {
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