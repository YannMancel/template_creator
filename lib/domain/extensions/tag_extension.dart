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
    int? id,
    math.Point<double>? origin,
    Size? size,
    Format? format,
    EdgeInsets? padding,
  }) {
    return when<Tag>(
      idle: () => IdleTag(
        id: id ?? this.id,
        origin: origin ?? this.origin,
        size: size ?? this.size,
        format: format ?? this.format,
        padding: padding ?? this.padding,
      ),
      selected: () => SelectedTag(
        id: id ?? this.id,
        origin: origin ?? this.origin,
        size: size ?? this.size,
        format: format ?? this.format,
        padding: padding ?? this.padding,
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
      idle: () => Colors.purpleAccent,
      selected: () => Colors.green,
    );
  }

  Tag get convertToSelectedTag {
    return when<Tag>(
      idle: () => SelectedTag(
        id: id,
        origin: origin,
        size: size,
        format: format,
        padding: padding,
      ),
      selected: () => this,
    );
  }

  Tag get convertToIdleTag {
    return when<Tag>(
      idle: () => this,
      selected: () => IdleTag(
        id: id,
        origin: origin,
        size: size,
        format: format,
        padding: padding,
      ),
    );
  }
}

extension TagsExt on List<Tag> {
  List<Tag> get reversedById {
    return List.of(this)
      ..sort(
        (a, b) => b.id.compareTo(a.id),
      );
  }
}
