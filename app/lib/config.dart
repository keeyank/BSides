import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpotifyConfig {
  static String get clientId => dotenv.env['SPOTIFY_CLIENT_ID']!;
  static String get clientSecret => dotenv.env['SPOTIFY_CLIENT_SECRET']!;
  static String get baseUrl => 'https://api.spotify.com/v1';
  static String get authUrl => 'https://accounts.spotify.com/api/token';
} 