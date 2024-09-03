import 'dart:math' as math;
import 'dart:ui';

extension SizeExt on Size {
  math.Point<double> get toBiggestPoint => math.Point<double>(width, height);
}
