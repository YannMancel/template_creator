import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:template_creator/_features.dart';

abstract interface class TagsLogic {
  ValueNotifier<List<Tag>> get tags;
  void addTag();
  void onDragStart({required math.Point<double> thumbPoint});
  void onDragUpdate({
    required math.Point<double> thumbPoint,
    required ({double maxWidth, double maxHeight}) constraints,
  });
  void onDragEnd();
}

final class TagsLogicImpl implements TagsLogic {
  late math.Point<double> _previousThumbPosition;

  @override
  final ValueNotifier<List<Tag>> tags = ValueNotifier<List<Tag>>(const <Tag>[]);

  @override
  void addTag() {
    final format = TextFormat(label: '${tags.value.length + 1}');
    final nextTag = IdleTag(format: format) as Tag;
    final stackedTags = tags.value.where(
      (tag) => tag.isStacked(nextTag),
    );
    tags.value = <Tag>[
      ...tags.value,
      nextTag.copyWith(level: stackedTags.length),
    ];
  }

  @override
  void onDragStart({required math.Point<double> thumbPoint}) {
    final stackedTags = tags.value.where(
      (tag) => tag.isIntoArea(thumbPoint),
    );
    if (stackedTags.isEmpty) return;

    final nearestTag = stackedTags.reduce(
      (a, b) => (a.level >= b.level) ? a : b,
    );

    _previousThumbPosition = thumbPoint;
    tags.value = <Tag>[
      for (final tag in tags.value)
        (tag == nearestTag) ? nearestTag.convertToSelectedTag : tag,
    ];
  }

  @override
  void onDragUpdate({
    required math.Point<double> thumbPoint,
    required ({double maxWidth, double maxHeight}) constraints,
  }) {
    final selectedTags = tags.value.where((tag) => tag.isSelected);
    if (selectedTags.isEmpty) return;
    final selectedTag = selectedTags.first;

    final delta = Offset(
      thumbPoint.x - _previousThumbPosition.x,
      thumbPoint.y - _previousThumbPosition.y,
    );
    final nextOrigin = math.Point<double>(
      (selectedTag.origin.x + delta.dx)
          .clamp(0.0, constraints.maxWidth - selectedTag.size.width),
      (selectedTag.origin.y + delta.dy)
          .clamp(0.0, constraints.maxHeight - selectedTag.size.height),
    );

    // How many tags are under selectedTag with nextOrigin?
    final idleTags = <Tag>[
      for (final tag in tags.value)
        if (tag != selectedTag) tag,
    ];
    final stackedTags = idleTags.where(
      (tag) => tag.isStacked(
        selectedTag.copyWith(origin: nextOrigin),
      ),
    );
    final updatedSelectedTag = selectedTag.copyWith(
      origin: nextOrigin,
      level: stackedTags.length,
    );

    // Update level of other tags.
    // final updatedTags = <Tag>[];
    // for (final idleTag in idleTags) {
    //   final stackedTags = idleTags.where(
    //     (tag) => (tag != idleTag) && tag.isStacked(idleTag),
    //   );
    //   updatedTags.add(
    //     idleTag.copyWith(level: stackedTags.length),
    //   );
    // }

    _previousThumbPosition = thumbPoint;
    tags.value = <Tag>[
      ...idleTags,
      //...updatedTags,
      updatedSelectedTag,
    ];
  }

  @override
  void onDragEnd() {
    tags.value = <Tag>[
      for (final tag in tags.value) tag.isSelected ? tag.convertToIdleTag : tag,
    ];
  }
}
