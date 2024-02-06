import 'package:flutter/widgets.dart';

abstract class Copyable<T> {
  @required
  T copy();
}
