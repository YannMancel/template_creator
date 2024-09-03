import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

@immutable
sealed class Tag {
  const Tag({
    required this.id,
    required this.origin,
    required this.size,
    required this.format,
  });

  final int id;
  final math.Point<double> origin;
  final Size size;
  final Format format;
}

@immutable
final class IdleTag extends Tag {
  const IdleTag({
    required super.id,
    super.origin = const math.Point<double>(0.0, 0.0),
    super.size = const Size.square(50.0),
    required super.format,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            id == other.id &&
            origin == other.origin &&
            size == other.size &&
            format == other.format);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        id,
        origin,
        size,
        format,
      ],
    );
  }
}

@immutable
final class SelectedTag extends Tag {
  const SelectedTag({
    required super.id,
    required super.origin,
    required super.size,
    required super.format,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            id == other.id &&
            origin == other.origin &&
            size == other.size &&
            format == other.format);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        id,
        origin,
        size,
        format,
      ],
    );
  }
}
