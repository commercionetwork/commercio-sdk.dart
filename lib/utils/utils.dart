/// Allows to easily perform common operations.
class Utils {
  /// Returns the ISO-8601 current time stamp
  static String getTimeStamp() {
    return DateTime.now().toIso8601String();
  }
}
