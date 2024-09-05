import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({super.key});

  void _onDragStart(DragStartDetails details, TemplateLogic logic) {
    logic.onDragStart(thumbPoint: details.localPosition.toPoint);
  }

  void _onDragUpdate(DragUpdateDetails details, TemplateLogic logic) {
    logic.onDragUpdate(thumbPoint: details.localPosition.toPoint);
  }

  void _onDragEnd(TemplateLogic logic) => logic.onDragEnd();

  @override
  Widget build(BuildContext context) {
    final logic = context.templateLogic;
    return ValueListenableBuilder<Template>(
      valueListenable: logic.template,
      builder: (_, template, __) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: SizedBox.fromSize(
          size: template.size,
          child: LayoutBuilder(
            builder: (_, constraints) {
              logic.constraints = constraints.biggest;
              return GestureDetector(
                onHorizontalDragStart: (details) {
                  _onDragStart(details, logic);
                },
                onVerticalDragStart: (details) {
                  _onDragStart(details, logic);
                },
                onHorizontalDragUpdate: (details) {
                  _onDragUpdate(details, logic);
                },
                onVerticalDragUpdate: (details) {
                  _onDragUpdate(details, logic);
                },
                onHorizontalDragEnd: (_) {
                  _onDragEnd(logic);
                },
                onVerticalDragEnd: (_) {
                  _onDragEnd(logic);
                },
                child: Stack(
                  children: <Widget>[
                    for (final tag in template.tags)
                      Positioned(
                        left: tag.origin.x,
                        top: tag.origin.y,
                        child: TagWidget(tag),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
