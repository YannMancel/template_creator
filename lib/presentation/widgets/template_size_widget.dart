import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSizeWidget extends StatelessWidget {
  const TemplateSizeWidget({super.key});

  void _updateWidthByStep(
    TemplateLogic logic, {
    required double step,
  }) {
    logic.updateWidth = logic.template.value.size.width + step;
  }

  void _updateHeightByStep(
    TemplateLogic logic, {
    required double step,
  }) {
    logic.updateHeight = logic.template.value.size.height + step;
  }

  @override
  Widget build(BuildContext context) {
    final logic = TemplateLogicWidget.of(context).logic;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ActionOnTemplateSize(
          title: 'Width',
          onPressedDecrease: () {
            _updateWidthByStep(logic, step: -10.0);
          },
          onPressedIncrease: () {
            _updateWidthByStep(logic, step: 10.0);
          },
        ),
        ActionOnTemplateSize(
          title: 'Height',
          onPressedDecrease: () {
            _updateHeightByStep(logic, step: -10.0);
          },
          onPressedIncrease: () {
            _updateHeightByStep(logic, step: 10.0);
          },
        ),
      ],
    );
  }
}

class ActionOnTemplateSize extends StatelessWidget {
  const ActionOnTemplateSize({
    super.key,
    required this.title,
    required this.onPressedDecrease,
    required this.onPressedIncrease,
  });

  final String title;
  final VoidCallback onPressedDecrease;
  final VoidCallback onPressedIncrease;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: OverflowBar(
        children: <Widget>[
          IconButton(
            onPressed: onPressedDecrease,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: onPressedIncrease,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
