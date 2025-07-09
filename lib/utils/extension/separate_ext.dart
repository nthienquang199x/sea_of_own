import 'package:flutter/material.dart';

extension IterableExt on Iterable<Widget> {
  Iterable<Widget> separatorBy(Widget element) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield element;
        yield iterator.current;
      }
    }
  }

  //another solution
  //Iterable<T> separatedBy(T separator) =>
  //  take(1).followedBy(skip(1).expand((element) => [separator, element]));

// Help to separated by widget in column, row
  List<Widget> separatedByToList(Widget separator) =>
      separatorBy(separator).toList();
}
