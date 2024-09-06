import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

@immutable
final class Template {
  const Template({
    this.size = const Size(300.0, 200.0),
    this.tags = const <Tag>[],
  });

  final Size size;

  /// The order is important. That allows to known the z position of [Tag]
  /// against the other [Tag]s.
  final List<Tag> tags;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is Template &&
            size == other.size &&
            tags.equals(other.tags));
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        size,
        tags,
      ],
    );
  }
}
