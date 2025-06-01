import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env.local");
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
    // Get access token
    final tokenResponse = await http.post(
      Uri.parse(SpotifyConfig.authUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ${base64Encode(utf8.encode('${SpotifyConfig.clientId}:${SpotifyConfig.clientSecret}'))}',
      },
      body: 'grant_type=client_credentials',
    );

    if (tokenResponse.statusCode == 200) {
      final tokenData = json.decode(tokenResponse.body);
      final accessToken = tokenData['access_token'];

      // Test search endpoint
      await http.get(
        Uri.parse('${SpotifyConfig.baseUrl}/search?q=test&type=track&limit=1'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
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
