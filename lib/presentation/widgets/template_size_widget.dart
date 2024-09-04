import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSizeWidget extends StatelessWidget {
  const TemplateSizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionsWidget(
      onUpdatedWidthByStep: (step) {
        final logic = context.templateLogic;
        logic.updateWidth = logic.template.value.size.width + step;
      },
      onUpdatedHeightByStep: (step) {
        final logic = context.templateLogic;
        logic.updateHeight = logic.template.value.size.height + step;
      },
    );
  }
}
