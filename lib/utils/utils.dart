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
/// the messages number [msgsAmount] contained in the transaction
/// and the default values [defaultAmount], [defaultDenom] and [defaultGas].
StdFee calculateDefaultFee(
  int msgsAmount,
  int defaultAmount,
  String defaultDenom,
  int defaultGas,
) {
  final fee = msgsAmount > 1
      ? StdFee(
          gas: (defaultGas * msgsAmount).toString(),
          amount: [
            StdCoin(
              denom: defaultDenom,
              amount: (defaultAmount * msgsAmount).toString(),
            ),
          ],
        )
      : StdFee(
          gas: defaultGas.toString(),
          amount: [
            StdCoin(
              denom: defaultDenom,
              amount: defaultAmount.toString(),
            ),
          ],
        );

  return fee;
}
