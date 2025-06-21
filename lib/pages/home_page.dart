import 'package:flutter/material.dart';
import '../spotify_service.dart';

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
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Spotify API Test!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testSpotifyAPI,
              child: const Text('Test Spotify API'),
            ),
          ],
        ),
      ),
    );
  }
} 