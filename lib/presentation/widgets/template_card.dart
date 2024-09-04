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
                        child: SizedBox.fromSize(
                          size: tag.size,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: tag.stateColor,
                              border: tag.border,
                              borderRadius: tag.borderRadius,
                              image: tag.format.when<DecorationImage?>(
                                text: (_, __, ___) => null,
                                image: (source) => DecorationImage(
                                  image: source.isNetworkUrl
                                      ? NetworkImage(source)
                                      : AssetImage(source),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: tag.padding,
                              child: tag.format.when<Widget?>(
                                text: (label, alignment, style) => Align(
                                  alignment: alignment,
                                  child: Text(
                                    label,
                                    style: style,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                image: (_) => null,
                              ),
                            ),
                          ),
                        ),
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
