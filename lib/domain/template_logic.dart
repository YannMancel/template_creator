import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:template_creator/_features.dart';

abstract interface class TemplateLogic {
  set updateWidth(double width);
  set updateHeight(double height);
  ValueNotifier<Template> get template;
  void addTag();
  void onDragStart({required math.Point<double> thumbPoint});
  void onDragUpdate({
    required math.Point<double> thumbPoint,
    required ({double maxWidth, double maxHeight}) constraints,
  });
  void onDragEnd();
}

final class TemplateLogicByValueNotifier implements TemplateLogic {
  late math.Point<double> _previousThumbPosition;

  @override
  set updateWidth(double width) {
    template.value = template.value.copyWith(
      size: Size(width, template.value.size.height),
    );
  }

  @override
  set updateHeight(double height) {
    template.value = template.value.copyWith(
      size: Size(template.value.size.width, height),
    );
  }

  @override
  final ValueNotifier<Template> template = ValueNotifier(const Template());

  @override
  void addTag() {
    final tags = template.value.tags;
    final format = TextFormat(label: '${tags.length + 1}');
    final nextTag = IdleTag(format: format) as Tag;
    final stackedTags = tags.where(
      (tag) => tag.isStacked(nextTag),
    );

    template.value = template.value.copyWith(
      tags: <Tag>[
        ...tags,
        nextTag.copyWith(level: stackedTags.length),
      ],
    );
  }

  @override
  void onDragStart({required math.Point<double> thumbPoint}) {
    final tags = template.value.tags;
    final stackedTags = tags.where(
      (tag) => tag.isIntoArea(thumbPoint),
    );
    if (stackedTags.isEmpty) return;
    final nearestTag = stackedTags.reduce(
      (a, b) => (a.level >= b.level) ? a : b,
    );

    _previousThumbPosition = thumbPoint;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final tag in tags)
          (tag == nearestTag) ? nearestTag.convertToSelectedTag : tag,
      ],
    );
  }

  @override
  void onDragUpdate({
    required math.Point<double> thumbPoint,
    required ({double maxWidth, double maxHeight}) constraints,
  }) {
    final tags = template.value.tags;
    final selectedTags = tags.where((tag) => tag.isSelected);
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
      for (final tag in tags)
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
    template.value = template.value.copyWith(
      tags: <Tag>[
        ...idleTags,
        //...updatedTags,
        updatedSelectedTag,
      ],
    );
  }

  @override
  void onDragEnd() {
    final tags = template.value.tags;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final tag in tags) tag.isSelected ? tag.convertToIdleTag : tag,
      ],
    );
  }
}
