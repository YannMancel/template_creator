import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagsLogicWidget extends InheritedWidget {
  const TagsLogicWidget({
    super.key,
    required this.logic,
    required super.child,
  });

  final TagsLogic logic;

  static TagsLogicWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TagsLogicWidget>();
  }

  static TagsLogicWidget of(BuildContext context) {
    final TagsLogicWidget? result = maybeOf(context);
    assert(result != null, 'No TagsLogicWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
