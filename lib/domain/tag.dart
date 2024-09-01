import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

@immutable
sealed class Tag {
  const Tag({
    required this.origin,
    required this.size,
    required this.level,
    required this.format,
  });

  final math.Point<double> origin;
  final Size size;
  final int level;
  final Format format;
}

@immutable
final class IdleTag extends Tag {
  const IdleTag({
    super.origin = const math.Point<double>(0.0, 0.0),
    super.size = const Size.square(50.0),
    super.level = 0,
    required super.format,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            origin == other.origin &&
            size == other.size &&
            level == other.level &&
            format == other.format);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        origin,
        size,
        level,
        format,
      ],
    );
  }
}

@immutable
final class SelectedTag extends Tag {
  const SelectedTag({
    required super.origin,
    required super.size,
    required super.level,
    required super.format,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            origin == other.origin &&
            size == other.size &&
            level == other.level &&
            format == other.format);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        origin,
        size,
        level,
        format,
      ],
    );
  }
}
