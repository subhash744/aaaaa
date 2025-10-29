# Supabase Next.js Application

A cloud-based application built with Next.js and Supabase featuring:
- User authentication (email/password)
- Photo storage and management
- Like functionality
- Live user count

## Features

1. **Authentication**: Sign up and sign in with email and password
2. **Profile Management**: Username and email management
3. **Photo Storage**: Upload and store photos in Supabase Storage
4. **Social Features**: Like photos from other users
5. **Real-time Data**: Live user count display

## Setup Instructions

### Prerequisites

- Node.js 18+
- A Supabase account (free tier available)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

### Supabase Setup

1. Create a new project in [Supabase](https://app.supabase.io/)
2. Get your project's URL and anon key from the API settings
3. Update the `.env.local` file with your Supabase credentials:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
   ```

### Database Setup

Run the SQL script in `SUPABASE_SCHEMA.sql` in your Supabase SQL editor to create the necessary tables and policies.

### Storage Setup

1. In your Supabase project, go to Storage
2. Create a new bucket named "photos"
3. Set the bucket to public for read access

### Running the Application

```bash
npm run dev
```

Visit `http://localhost:3000` to view the application.

## Project Structure

```
├── context/
│   └── AuthContext.tsx      # Authentication context
├── src/
│   ├── app/
│   │   ├── api/
│   │   │   └── user-count/
│   │   │       └── route.ts  # API route for user count
│   │   ├── layout.tsx        # Root layout with AuthProvider
│   │   └── page.tsx          # Main page with all functionality
│   └── utils/
│       └── supabaseClient.ts # Supabase client configuration
├── .env.local               # Environment variables
├── SUPABASE_SCHEMA.sql      # Database schema and RLS policies
└── package.json             # Dependencies and scripts
```

## Key Components

### Authentication
- Uses Supabase Auth for user management
- Provides sign up, sign in, and sign out functionality
- Maintains user session state

### Photo Management
- Upload photos to Supabase Storage
- Display photos in a responsive grid
- Track photo ownership

### Social Features
- Like/unlike photos
- Real-time like counts

### Real-time Data
- Live user count updated every 5 seconds
- API endpoint for fetching user count

## Security

- Row Level Security (RLS) policies protect data
- Users can only modify their own data
- Public read access for photos and profiles