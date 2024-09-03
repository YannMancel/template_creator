import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateLogicWidget extends InheritedWidget {
  const TemplateLogicWidget({
    super.key,
    required this.logic,
    required super.child,
  });

  final TemplateLogic logic;

  static TemplateLogicWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TemplateLogicWidget>();
  }

  static TemplateLogicWidget of(BuildContext context) {
    final TemplateLogicWidget? result = maybeOf(context);
    assert(result != null, 'No TemplateLogicWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
