-- Supabase Database Schema

-- 1. Users table (managed by Supabase Auth, but we can create a profile table)
-- This table is automatically created by Supabase Auth

-- 2. Profiles table
create table profiles (
  id uuid references auth.users on delete cascade not null primary key,
  updated_at timestamp with time zone,
  username text unique,
  email text,
  description text,
  image_url text
);

-- 3. Photos table
create table photos (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  url text,
  filename text,
  user_id uuid references auth.users on delete cascade not null
);

-- 4. Likes table
create table likes (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  user_id uuid references auth.users on delete cascade not null,
  photo_id uuid references photos on delete cascade not null,
  unique(user_id, photo_id)
);

-- Storage buckets for photos and profile images
insert into storage.buckets (id, name)
  values ('photos', 'photos');

insert into storage.buckets (id, name)
  values ('profile-images', 'profile-images');

-- RLS policies
alter table profiles enable row level security;
alter table photos enable row level security;
alter table likes enable row level security;

-- Profiles policies
create policy "Public profiles are viewable by everyone."
  on profiles for select
  using ( true );

create policy "Users can insert their own profile."
  on profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on profiles for update
  using ( auth.uid() = id );

-- Photos policies
create policy "Photos are viewable by everyone."
  on photos for select
  using ( true );

create policy "Users can insert their own photos."
  on photos for insert
  with check ( auth.uid() = user_id );

create policy "Users can delete their own photos."
  on photos for delete
  using ( auth.uid() = user_id );

-- Likes policies
create policy "Likes are viewable by everyone."
  on likes for select
  using ( true );

create policy "Users can insert their own likes."
  on likes for insert
  with check ( auth.uid() = user_id );

create policy "Users can delete their own likes."
  on likes for delete
  using ( auth.uid() = user_id );

-- Storage policies for photos
create policy "Photos are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'photos' );

create policy "Anyone can upload a photo."
  on storage.objects for insert
  with check ( bucket_id = 'photos' );

create policy "Anyone can update their own photo."
  on storage.objects for update
  using ( bucket_id = 'photos' AND auth.uid() = owner );

create policy "Anyone can delete their own photo."
  on storage.objects for delete
  using ( bucket_id = 'photos' AND auth.uid() = owner );

-- Storage policies for profile images
create policy "Profile images are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'profile-images' );

create policy "Anyone can upload a profile image."
  on storage.objects for insert
  with check ( bucket_id = 'profile-images' );

create policy "Anyone can update their own profile image."
  on storage.objects for update
  using ( bucket_id = 'profile-images' AND auth.uid() = owner );

create policy "Anyone can delete their own profile image."
  on storage.objects for delete
  using ( bucket_id = 'profile-images' AND auth.uid() = owner );