import 'dart:math' as math;

import 'package:flutter/material.dart';

extension OffsetExt on Offset {
  math.Point<double> get toPoint => math.Point<double>(dx, dy);
}
