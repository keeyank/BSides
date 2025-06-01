# BSides - Spotify Music Review App

A Flutter app for searching and reviewing music using the Spotify Web API.

## Setup

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Configure Spotify API
1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new app
3. Copy your Client ID and Client Secret

### 3. Environment Configuration
Create a `.env.local` file in the project root with your Spotify credentials:

```
SPOTIFY_CLIENT_ID=your_client_id_here
SPOTIFY_CLIENT_SECRET=your_client_secret_here
```

**Important:** Never commit `.env.local` to version control. It's already in `.gitignore`.

### 4. Run the App
```bash
# For web (recommended for development)
flutter run -d web-server

# For other platforms (requires platform-specific setup)
flutter run
```

## Current Features
- Basic Spotify API authentication test
- Simple button to verify API connectivity

## Development Plan
See `PLAN.md` for the full development roadmap including search functionality and review features.