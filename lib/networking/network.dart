import 'dart:convert';

import 'package:http/http.dart' as http;

/// Allows to easily perform network-related operations.
class Network {
  static var client = http.Client();

  /// Queries the given [url] and returns an object of type [T],
  /// or `null` if some error raised.
  static Future<dynamic> queryChain(String url) async {
    try {
      // Get the response
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw Exception(
          "Expected status code 200 but got ${response.statusCode} - ${response.body}",
        );
      }

      // Return the result part of the response
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json["result"];
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  static Future<dynamic> query(String url) async {
    try {
      final response = await client.get(url);
      if (response.statusCode != 200) {
        throw Exception(
          "Expected status code 200 but got ${response.statusCode} - ${response.body}",
        );
      }

      return response.body;
    } catch (exception) {
      return null;
    }
  }
}
