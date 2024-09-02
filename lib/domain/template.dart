import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

@immutable
final class Template {
  const Template({
    this.size = const Size(300.0, 200.0),
    this.tags = const <Tag>[],
  });

  final Size size;
  final List<Tag> tags;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is Template &&
            size == other.size &&
            const DeepCollectionEquality().equals(tags, other.tags));
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
