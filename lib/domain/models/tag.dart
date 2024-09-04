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
    required this.padding,
    required this.border,
    required this.borderRadius,
    required this.backgroundColor,
  });

  final int id;
  final math.Point<double> origin;
  final Size size;
  final Format format;
  final EdgeInsets padding;
  final Border border;
  final BorderRadius borderRadius;
  final Color backgroundColor;
}

@immutable
final class IdleTag extends Tag {
  const IdleTag({
    required super.id,
    super.origin = const math.Point<double>(0.0, 0.0),
    super.size = const Size.square(50.0),
    required super.format,
    super.padding = const EdgeInsets.all(8.0),
    super.border = const Border.symmetric(
      horizontal: BorderSide(),
      vertical: BorderSide(),
    ),
    super.borderRadius = const BorderRadius.all(
      Radius.circular(4.0),
    ),
    super.backgroundColor = Colors.purpleAccent,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            id == other.id &&
            origin == other.origin &&
            size == other.size &&
            format == other.format &&
            padding == other.padding &&
            border == other.border &&
            borderRadius == other.borderRadius &&
            backgroundColor == other.backgroundColor);
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
        padding,
        border,
        borderRadius,
        backgroundColor,
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
    required super.padding,
    required super.border,
    required super.borderRadius,
    required super.backgroundColor,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is IdleTag &&
            id == other.id &&
            origin == other.origin &&
            size == other.size &&
            format == other.format &&
            padding == other.padding &&
            border == other.border &&
            borderRadius == other.borderRadius &&
            backgroundColor == other.backgroundColor);
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
        padding,
        border,
        borderRadius,
        backgroundColor,
      ],
    );
  }
}
