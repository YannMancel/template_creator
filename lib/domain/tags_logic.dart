import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:template_creator/_features.dart';

abstract interface class TagsLogic {
  ValueNotifier<Tag?> get tag;
  void addTag();
  void onDragStart({required Offset thumbPosition});
  void onDragUpdate({
    required Offset thumbPosition,
    required double maxWidth,
    required double maxHeight,
  });
  void onDragEnd();
}

final class TagsLogicImpl implements TagsLogic {
  late math.Point<double> _thumbPosition;

  @override
  final ValueNotifier<Tag?> tag = ValueNotifier<Tag?>(null);

  @override
  void addTag() {
    if (tag.value != null) return;
    tag.value = const IdleTag();
  }

  @override
  void onDragStart({required Offset thumbPosition}) {
    assert(tag.value != null, 'tag must be not null.');
    if (tag.value == null) return;

    _thumbPosition = math.Point<double>(thumbPosition.dx, thumbPosition.dy);

    final isSelected = tag.value!.isIntoArea(point: _thumbPosition);
    final nextTagVersion = tag.value!.when<Tag?>(
      idle: () => isSelected
          ? SelectedTag(
              origin: tag.value!.origin,
              size: tag.value!.size,
            )
          : null,
      selected: () => !isSelected
          ? IdleTag(
              origin: tag.value!.origin,
              size: tag.value!.size,
            )
          : null,
      //TODO manage error
      error: () => null,
    );

    if (nextTagVersion != null) tag.value = nextTagVersion;
  }

  @override
  void onDragUpdate({
    required Offset thumbPosition,
    required double maxWidth,
    required double maxHeight,
  }) {
    assert(tag.value != null, 'tag must be not null.');
    if (tag.value == null) return;
    if (!tag.value!.isSelected) return;

    final delta = Offset(
      thumbPosition.dx - _thumbPosition.x,
      thumbPosition.dy - _thumbPosition.y,
    );

    final nextOrigin = math.Point<double>(
      (tag.value!.origin.x + delta.dx)
          .clamp(0.0, maxWidth - tag.value!.size.width),
      (tag.value!.origin.y + delta.dy)
          .clamp(0.0, maxHeight - tag.value!.size.height),
    );
    final nextTagVersion = SelectedTag(
      origin: nextOrigin,
      size: tag.value!.size,
    );

    _thumbPosition = math.Point<double>(thumbPosition.dx, thumbPosition.dy);
    tag.value = nextTagVersion;
  }

  @override
  void onDragEnd() {
    assert(tag.value != null, 'tag must be not null.');
    if (tag.value == null) return;
    if (!tag.value!.isSelected) return;

    final nextTagVersion = IdleTag(
      origin: tag.value!.origin,
      size: tag.value!.size,
    );
    tag.value = nextTagVersion;
  }
}
