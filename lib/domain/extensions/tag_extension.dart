import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

extension TagExt on Tag {
  math.Rectangle<double> get rectangle {
    return math.Rectangle(
      origin.x,
      origin.y,
      size.width,
      size.height,
    );
  }

  bool isIntoArea(math.Point<double> point) {
    return rectangle.containsPoint(point);
  }

  T when<T>({
    required ValueGetter<T> idle,
    required ValueGetter<T> selected,
  }) {
    return switch (this) {
      IdleTag() => idle(),
      SelectedTag() => selected(),
    };
  }

  Tag copyWith({
    math.Point<double>? origin,
    Size? size,
    Format? format,
  }) {
    return when<Tag>(
      idle: () => IdleTag(
        origin: origin ?? this.origin,
        size: size ?? this.size,
        format: format ?? this.format,
      ),
      selected: () => SelectedTag(
        origin: origin ?? this.origin,
        size: size ?? this.size,
        format: format ?? this.format,
      ),
    );
  }

  bool get isSelected {
    return when<bool>(
      idle: () => false,
      selected: () => true,
    );
  }

  Color get color {
    return when<Color>(
      idle: () => kIdleColor,
      selected: () => kSelectedColor,
    );
  }

  Tag get convertToSelectedTag {
    return when<Tag>(
      idle: () => SelectedTag(
        origin: origin,
        size: size,
        format: format,
      ),
      selected: () => this,
    );
  }

  Tag get convertToIdleTag {
    return when<Tag>(
      idle: () => this,
      selected: () => IdleTag(
        origin: origin,
        size: size,
        format: format,
      ),
    );
  }
}
