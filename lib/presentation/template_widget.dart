import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateWidget extends StatelessWidget {
  const TemplateWidget({super.key});

  void _onDragStart(DragStartDetails details, TemplateLogic logic) {
    logic.onDragStart(thumbPoint: details.localPosition.toPoint);
  }

  void _onDragUpdate(
    DragUpdateDetails details,
    TemplateLogic logic,
    BoxConstraints constraints,
  ) {
    logic.onDragUpdate(
      thumbPoint: details.localPosition.toPoint,
      constraints: (
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
      ),
    );
  }

  void _onDragEnd(TemplateLogic logic) => logic.onDragEnd();

  @override
  Widget build(BuildContext context) {
    final logic = TemplateLogicWidget.of(context).logic;
    return ValueListenableBuilder<Template>(
      valueListenable: logic.template,
      builder: (_, template, __) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: SizedBox.fromSize(
          size: template.size,
          child: LayoutBuilder(
            builder: (_, constraints) => GestureDetector(
              onHorizontalDragStart: (details) => _onDragStart(details, logic),
              onVerticalDragStart: (details) => _onDragStart(details, logic),
              onHorizontalDragUpdate: (details) => _onDragUpdate(
                details,
                logic,
                constraints,
              ),
              onVerticalDragUpdate: (details) => _onDragUpdate(
                details,
                logic,
                constraints,
              ),
              onHorizontalDragEnd: (_) => _onDragEnd(logic),
              onVerticalDragEnd: (_) => _onDragEnd(logic),
              child: Stack(
                children: <Widget>[
                  for (final tag in template.tags)
                    Positioned(
                      left: tag.origin.x,
                      top: tag.origin.y,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: tag.color,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: SizedBox.fromSize(
                          size: tag.size,
                          child: tag.format.when<Widget>(
                            text: (label) => Center(
                              child: Text(label),
                            ),
                            image: (source) => DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: source.isNetworkUrl
                                      ? NetworkImage(source)
                                      : AssetImage(source),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
