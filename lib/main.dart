import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'spotify_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env.local");
  } catch (e) {
    print('Error loading .env.local: $e');
    // Continue anyway - the app will still run but API calls will fail
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify API Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _testSpotifyAPI() async {
    try {
      final spotifyService = SpotifyService();
      final result = await spotifyService.searchTracks("Hit me baby one more time", limit: 10);
      print('Search result: $result');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify API Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _testSpotifyAPI,
          child: const Text('Test Spotify API'),
        ),
      ),
    );
  }
}
