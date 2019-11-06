import 'package:commerciosdk/crypto/export.dart';


/// Returns the ISO-8601 current time stamp
String getTimeStamp() {
  return DateTime.now().toIso8601String();
}
