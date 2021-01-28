import 'dart:convert';

import 'package:http/http.dart' as http;

/// Allows to easily perform network-related operations.
class Network {
  /// Sends a GET request the given [url] with optional [client] and returns
  /// the JSON deserialized result or `null` if some error happens.
  ///
  /// This method it's intended to query the chain that exposes JSON responses
  /// with a `result` field in where we are interested.
  static Future<dynamic> queryChain(
    String url, {
    http.Client client,
  }) async {
    try {
      final responseBody = await query(url, client: client);

      // Return the result part of the response
      final json = jsonDecode(responseBody) as Map<String, dynamic>;

      if (!json.containsKey('result')) {
        throw Exception('The JSON response does not contains the "result" key');
      }

      return json['result'];
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  /// Sends a GET request to [url] with optional [client] and returns the
  /// response body or `null` if any exception happens.
  static Future<String> query(String url, {http.Client client}) async {
    client = client ?? http.Client();

    try {
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw Exception(
          'Expected status code 200 but got ${response.statusCode} - ${response.body}',
        );
      }

      return response.body;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
