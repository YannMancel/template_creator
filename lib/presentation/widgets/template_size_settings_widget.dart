import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSizeSettingsWidget extends StatelessWidget {
  const TemplateSizeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizeButtons(
      onWidthStepUpdate: (step) {
        final logic = context.templateLogic;
        logic.updateWidth = logic.template.value.size.width + step;
      },
      onHeightStepUpdate: (step) {
        final logic = context.templateLogic;
        logic.updateHeight = logic.template.value.size.height + step;
      },
    );
  }
}
