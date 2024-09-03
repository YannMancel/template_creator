import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSizeWidget extends StatelessWidget {
  const TemplateSizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = TemplateLogicWidget.of(context).logic;
    return ActionsWidget(
      onUpdatedWidthByStep: (step) {
        logic.updateWidth = logic.template.value.size.width + step;
      },
      onUpdatedHeightByStep: (step) {
        logic.updateHeight = logic.template.value.size.height + step;
      },
    );
  }
}
