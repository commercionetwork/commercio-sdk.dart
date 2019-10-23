/// Allows to easily perform network-related operations.
class Network {
  /// Queries the given [url] and returns an object of type [T],
  /// or `null` if some error raised.
  static Future<T> query<T>(String url) async {
    try {} catch (exception) {
      return null;
    }
  }
}
