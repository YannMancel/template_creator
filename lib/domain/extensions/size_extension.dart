import 'dart:math' as math;
import 'dart:ui';

extension SizeExt on Size {
  math.Point<double> get toBiggestPoint => math.Point<double>(width, height);

  Size clampByRectangle(math.Rectangle<double> rectangle) {
    return Size(
      width.clamp(rectangle.left, rectangle.width),
      height.clamp(rectangle.top, rectangle.height),
    );
  }
}
