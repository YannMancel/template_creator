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

  bool isStacked(Tag tag) {
    return rectangle.intersects(tag.rectangle);
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
    int? level,
    Format? format,
  }) {
    return when<Tag>(
      idle: () => IdleTag(
        origin: origin ?? this.origin,
        size: size ?? this.size,
        level: level ?? this.level,
        format: format ?? this.format,
      ),
      selected: () => SelectedTag(
        origin: origin ?? this.origin,
        size: size ?? this.size,
        level: level ?? this.level,
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
      idle: () => kIdleColors[level % kIdleColors.length],
      selected: () => kSelectedColor,
    );
  }

  Tag get convertToSelectedTag {
    return when<Tag>(
      idle: () => SelectedTag(
        origin: origin,
        size: size,
        level: level,
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
        level: level,
        format: format,
      ),
    );
  }
}
