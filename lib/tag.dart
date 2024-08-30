import 'dart:math' as math;

import 'package:flutter/material.dart';

sealed class Tag {
  const Tag({
    required this.origin,
    required this.size,
    required this.color,
  });

  final math.Point<double> origin;
  final Size size;
  final Color color;

  bool isIntoArea({required math.Point<double> point}) {
    return origin.x <= point.x &&
        point.x <= (origin.x + size.width) &&
        origin.y <= point.y &&
        point.y <= (origin.y + size.height);
  }

  T when<T>({
    required ValueGetter<T> idle,
    required ValueGetter<T> selected,
    required ValueGetter<T> error,
  }) {
    return switch (this) {
      IdleTag() => idle(),
      SelectedTag() => selected(),
      ErrorTag() => error(),
    };
  }

  bool get isSelected {
    return when<bool>(
      idle: () => false,
      selected: () => true,
      error: () => false,
    );
  }
}

final class IdleTag extends Tag {
  const IdleTag({
    super.origin = const math.Point<double>(0.0, 0.0),
    super.size = const Size.square(50.0),
  }) : super(color: Colors.cyan);
}

final class SelectedTag extends Tag {
  const SelectedTag({
    required super.origin,
    required super.size,
  }) : super(color: Colors.green);
}

final class ErrorTag extends Tag {
  const ErrorTag({
    required super.origin,
    required super.size,
  }) : super(color: Colors.red);
}
