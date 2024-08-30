import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateWidget extends StatelessWidget {
  const TemplateWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final logic = TagsLogicWidget.of(context).logic;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox.fromSize(
        size: size,
        child: LayoutBuilder(
          builder: (_, constraints) {
            return GestureDetector(
              onHorizontalDragStart: (details) => logic.onDragStart(
                thumbPosition: details.localPosition,
              ),
              onVerticalDragStart: (details) => logic.onDragStart(
                thumbPosition: details.localPosition,
              ),
              onHorizontalDragUpdate: (details) => logic.onDragUpdate(
                thumbPosition: details.localPosition,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
              ),
              onVerticalDragUpdate: (details) => logic.onDragUpdate(
                thumbPosition: details.localPosition,
                maxWidth: constraints.maxWidth,
                maxHeight: constraints.maxHeight,
              ),
              onHorizontalDragEnd: (_) => logic.onDragEnd(),
              onVerticalDragEnd: (_) => logic.onDragEnd(),
              child: Stack(
                children: <Widget>[
                  ValueListenableBuilder<Tag>(
                    valueListenable: logic.tag,
                    builder: (_, tag, __) {
                      return Positioned(
                        left: tag.origin.x,
                        top: tag.origin.y,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: tag.color,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: SizedBox.fromSize(size: tag.size),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
