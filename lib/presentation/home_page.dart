import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

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
    final inversePrimaryColor = Theme.of(context).colorScheme.inversePrimary;
    final logic = TemplateLogicWidget.of(context).logic;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: inversePrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                const Center(
                  child: TemplateWidget(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: logic.addTag,
                    icon: const Icon(Icons.add),
                    label: const Text('Tag'),
                  ),
                ),
              ],
            ),
          ),
          ColoredBox(
            color: inversePrimaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ActionOnTemplateSize(
                  title: 'Width',
                  onPressedDecrease: () => _updateWidthByStep(
                    logic,
                    step: -10.0,
                  ),
                  onPressedIncrease: () => _updateWidthByStep(
                    logic,
                    step: 10.0,
                  ),
                ),
                ActionOnTemplateSize(
                  title: 'Height',
                  onPressedDecrease: () => _updateHeightByStep(
                    logic,
                    step: -10.0,
                  ),
                  onPressedIncrease: () => _updateHeightByStep(
                    logic,
                    step: 10.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
