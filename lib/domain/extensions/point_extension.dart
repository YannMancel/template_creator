import 'dart:math' as math;

extension DoublePointExt on math.Point<double> {
  math.Point<double> clampByRectangle(math.Rectangle<double> rectangle) {
    return math.Point<double>(
      x.clamp(rectangle.left, rectangle.width),
      y.clamp(rectangle.top, rectangle.height),
    );
  }
}
