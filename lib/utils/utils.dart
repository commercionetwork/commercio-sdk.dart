import 'dart:convert';

import '../export.dart';

/// Returns the ISO-8601 current time stamp
String getTimeStamp() {
  return DateTime.now().toUtc().toIso8601String();
}

///Porting of Kotlin mapIndexed()
///Returns an [Iterable] containing the result of applying the given [transform] function
///to each [item] and its [index] contained in [items].
///[transform] function that takes the [index] of an [item] and the [item] itself and
///returns the result of the transform applied to the [item].
Iterable<E> mapIndexed<E, T>(
    Iterable<T> items, E Function(int index, T item) transform) sync* {
  var index = 0;

  for (final item in items) {
    yield transform(index, item);
    index = index + 1;
  }
}

/// Calculates the default fees from
/// the messages number [msgsNumber] contained in the transaction
/// and the default values [fee], [denom] and [gas].
StdFee calculateDefaultFee({
  required int msgsNumber,
  required int fee,
  required String denom,
  required int gas,
}) {
  return StdFee(
    gas: (gas * msgsNumber).toString(),
    amount: [
      StdCoin(
        denom: denom,
        amount: (fee * msgsNumber).toString(),
      ),
    ],
  );
}

/// Returns [true] if the bytes length of a string [str] is less than a certain
/// value [len].
bool checkStringBytesLen(String str, int len) {
  final bytes = utf8.encode(str);
  return bytes.length <= len;
}

/// Return [true] if the string [uuid] has a Uuid v4 format.
bool matchUuidv4(String uuid) {
  final regExp = RegExp(
    r'^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$',
    caseSensitive: false,
  );
  return regExp.hasMatch(uuid);
}

/// Returns [true] if the provided [str] is a valid bech32 string
/// (no checksum check is done).
/// See: https://en.bitcoin.it/wiki/Bech32
bool matchBech32Format(String? str) {
  if (str == null) {
    throw ArgumentError('(str) must not be null');
  }

  if (str.length < 8 || str.length > 90) {
    return false;
  }

  final regExp = RegExp(r'^(\S{1,83})(1)([^1bio]{6,88})$');

  return regExp.hasMatch(str);
}
