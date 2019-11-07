import 'package:commerciosdk/crypto/export.dart';


/// Returns the ISO-8601 current time stamp
String getTimeStamp() {
  return DateTime.now().toIso8601String();
}

///Porting of Kotlin mapIndexed()
///Returns an [Iterable] containing the result of applying the given [transform] function
///to each [item] and its [index] contained in [items].
///[transform] function that takes the [index] of an [item] and the [item] itself and
///returns the result of the transform applied to the [item].
Iterable<E> mapIndexed<E, T>(Iterable<T> items, E Function(int index, T item) transform) sync* {
  var index = 0;

  for (final item in items) {
    yield transform(index, item);
    index = index + 1;
  }
}
