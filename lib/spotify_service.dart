import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

class SpotifyService {
  static final SpotifyService _instance = SpotifyService._internal();
  factory SpotifyService() => _instance;
  SpotifyService._internal();

  String? _accessToken;
  DateTime? _tokenExpiry;

  // Check if current token is still valid
  bool get _isTokenValid {
    if (_accessToken == null || _tokenExpiry == null) return false;
    return DateTime.now().isBefore(_tokenExpiry!.subtract(Duration(minutes: 5))); // 5 min buffer
  }

  // Get a valid access token (refresh if needed)
  Future<String> _getValidToken() async {
    if (_isTokenValid) {
      return _accessToken!;
    }

    // Token is expired or doesn't exist, get a new one
    await _refreshToken();
    return _accessToken!;
  }

  // Refresh the access token
  Future<void> _refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse(SpotifyConfig.authUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('${SpotifyConfig.clientId}:${SpotifyConfig.clientSecret}'))}',
        },
        body: 'grant_type=client_credentials',
      );

      if (response.statusCode == 200) {
        final tokenData = json.decode(response.body);
        _accessToken = tokenData['access_token'];
        final expiresIn = tokenData['expires_in'] as int; // seconds
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
        
        print('Token refreshed successfully. Expires in $expiresIn seconds');
      } else {
        throw Exception('Failed to refresh token: ${response.statusCode}');
      }
    } catch (e) {
      print('Error refreshing token: $e');
      rethrow;
    }
  }

  // Make an authenticated API call with automatic retry on 401
  Future<http.Response> _makeAuthenticatedRequest(
    String method,
    String url, {
    Map<String, String>? headers,
    String? body,
  }) async {
    final token = await _getValidToken();
    
    final requestHeaders = {
      'Authorization': 'Bearer $token',
      ...?headers,
    };

    http.Response response;
    
    // Make the request
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(Uri.parse(url), headers: requestHeaders);
        break;
      case 'POST':
        response = await http.post(Uri.parse(url), headers: requestHeaders, body: body);
        break;
      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    // If we get 401 (Unauthorized), try refreshing token once
    if (response.statusCode == 401) {
      print('Received 401, refreshing token and retrying...');
      await _refreshToken();
      
      // Update token in headers and retry
      requestHeaders['Authorization'] = 'Bearer $_accessToken';
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(Uri.parse(url), headers: requestHeaders, body: body);
          break;
      }
    }

    return response;
  }

  // Search for Spotify data
  Future<Map<String, dynamic>> search(String query, String type, {int limit = 20}) async {
    try {
      if (!({"track", "album"}.contains(type))) {
        throw Exception('Search failed: $type is not a valid Spotify data type');
      }
      final url = '${SpotifyConfig.baseUrl}/search?q=${Uri.encodeComponent(query)}&type=$type&limit=$limit';
      final response = await _makeAuthenticatedRequest('GET', url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Search failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error searching tracks: $e');
      rethrow;
    }
  }

  // Clear cached token (useful for testing or logout)
  void clearToken() {
    _accessToken = null;
    _tokenExpiry = null;
  }
} 