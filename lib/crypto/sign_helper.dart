import 'dart:convert';
import 'dart:typed_data';

import 'package:sacco/sacco.dart';
import 'package:sacco/utils/export.dart';

/// Allows to easily perform signature-related operations.
class SignHelper {
  /// Takes the given [data], converts it to an alphabetically sorted
  /// JSON object and signs its content using the given [wallet].
  static Uint8List signSorted(dynamic data, Wallet wallet) {
    var sorted = data;
    if (data is Map<String, dynamic>) {
      sorted = MapSorter.sort(data);
    }

    return wallet.sign(utf8.encode(json.encode(sorted)));
  }
}
