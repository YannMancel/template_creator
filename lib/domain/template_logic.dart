import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:template_creator/_features.dart';

abstract interface class TemplateLogic {
  set constraints(Size constraints);
  ValueNotifier<Template> get template;
  set updateWidth(double width);
  set updateHeight(double height);
  void addTag();
  void updateTagWidth(Tag tag, {required double width});
  void updateTagHeight(Tag tag, {required double height});
  void onDragStart({required math.Point<double> thumbPoint});
  void onDragUpdate({required math.Point<double> thumbPoint});
  void onDragEnd();
}

final class TemplateLogicByValueNotifier implements TemplateLogic {
  late math.Point<double> _previousThumbPosition;
  late Size _constraints;

  static const kMinTagSize = Size.square(20.0);

  @override
  set constraints(Size constraints) => _constraints = constraints;

  @override
  final ValueNotifier<Template> template = ValueNotifier(const Template());

  @override
  set updateWidth(double width) {
    template.value = template.value.copyWith(
      size: Size(width, template.value.size.height),
    );
    //TODO(Yann): update tags
  }

  @override
  set updateHeight(double height) {
    template.value = template.value.copyWith(
      size: Size(template.value.size.width, height),
    );
    //TODO(Yann): update tags
  }

  @override
  void addTag() {
    final tags = template.value.tags;
    final id = tags.length;
    template.value = template.value.copyWith(
      tags: <Tag>[
        ...tags,
        IdleTag(
          id: id,
          format: TextFormat(label: '$id'),
        ),
      ],
    );
  }

  @override
  void updateTagWidth(Tag tag, {required double width}) {
    final sizeBoundaries = math.Rectangle.fromPoints(
      kMinTagSize.toBiggestPoint,
      _constraints.toBiggestPoint - tag.origin,
    );
    final updatedTag = tag.copyWith(
      size: Size(width, tag.size.height).clampByRectangle(sizeBoundaries),
    );
    final tags = template.value.tags;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final idleTag in tags) (idleTag == tag) ? updatedTag : idleTag,
      ],
    );
  }

  @override
  void updateTagHeight(Tag tag, {required double height}) {
    final sizeBoundaries = math.Rectangle.fromPoints(
      kMinTagSize.toBiggestPoint,
      _constraints.toBiggestPoint - tag.origin,
    );
    final updatedTag = tag.copyWith(
      size: Size(tag.size.width, height).clampByRectangle(sizeBoundaries),
    );
    final tags = template.value.tags;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final idleTag in tags) (idleTag == tag) ? updatedTag : idleTag,
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
      (a, b) => (tags.indexOf(a) >= tags.indexOf(b)) ? a : b,
    );
    _previousThumbPosition = thumbPoint;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final tag in tags)
          if (tag != nearestTag) tag,
        nearestTag.convertToSelectedTag,
      ],
    );
  }

  @override
  void onDragUpdate({required math.Point<double> thumbPoint}) {
    final tags = template.value.tags;
    final selectedTags = tags.where((tag) => tag.isSelected);
    if (selectedTags.isEmpty) return;
    final selectedTag = selectedTags.first;
    final dragDelta = thumbPoint - _previousThumbPosition;
    final originBoundaries = math.Rectangle.fromPoints(
      const math.Point<double>(0.0, 0.0),
      _constraints.toBiggestPoint - selectedTag.size.toBiggestPoint,
    );
    final updatedOrigin =
        (selectedTag.origin + dragDelta).clampByRectangle(originBoundaries);
    _previousThumbPosition = thumbPoint;
    template.value = template.value.copyWith(
      tags: <Tag>[
        for (final tag in tags)
          tag.isSelected ? tag.copyWith(origin: updatedOrigin) : tag,
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
