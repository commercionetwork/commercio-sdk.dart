import 'dart:typed_data';

import 'package:sacco/sacco.dart';
import 'package:sacco/utils/export.dart';

/// Allows to easily perform signature-related operations.
class SignHelper {
  /// Takes the given [data], converts it to an alphabetically sorted
  /// JSON object and signs its content using the given [wallet].
  static Uint8List signSorted(Map<String, dynamic> data, Wallet wallet) {
    var sorted = MapSorter.sort(data);
    return wallet.signData(sorted);
  }
}
