import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:template_creator/tag.dart';

class TemplateWidget extends StatefulWidget {
  const TemplateWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {
  late Tag _tag;
  late math.Point<double> _thumbPosition;

  void _onDragStart({required Offset thumbPosition}) {
    _thumbPosition = math.Point<double>(thumbPosition.dx, thumbPosition.dy);

    final isSelected = _tag.isIntoArea(point: _thumbPosition);
    final nextTagVersion = _tag.when<Tag?>(
      idle: () => isSelected
          ? SelectedTag(
              origin: _tag.origin,
              size: _tag.size,
            )
          : null,
      selected: () => !isSelected
          ? IdleTag(
              origin: _tag.origin,
              size: _tag.size,
            )
          : null,
      //TODO manage error
      error: () => null,
    );

    if (nextTagVersion != null) setState(() => _tag = nextTagVersion);
  }

  void _onDragUpdate(
    BoxConstraints constraints, {
    required Offset thumbPosition,
  }) {
    if (!_tag.isSelected) return;

    final delta = Offset(
      thumbPosition.dx - _thumbPosition.x,
      thumbPosition.dy - _thumbPosition.y,
    );

    final nextOrigin = math.Point<double>(
      (_tag.origin.x + delta.dx)
          .clamp(0.0, constraints.maxWidth - _tag.size.width),
      (_tag.origin.y + delta.dy)
          .clamp(0.0, constraints.maxHeight - _tag.size.height),
    );
    final nextTagVersion = SelectedTag(
      origin: nextOrigin,
      size: _tag.size,
    );

    _thumbPosition = math.Point<double>(thumbPosition.dx, thumbPosition.dy);
    setState(() => _tag = nextTagVersion);
  }

  void _onDragEnd() {
    final nextTagVersion = IdleTag(
      origin: _tag.origin,
      size: _tag.size,
    );
    setState(() => _tag = nextTagVersion);
  }

  @override
  void initState() {
    super.initState();
    _tag = const IdleTag();
    _thumbPosition = const math.Point<double>(0.0, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox.fromSize(
        size: widget.size,
        child: LayoutBuilder(
          builder: (_, constraints) {
            return GestureDetector(
              onHorizontalDragStart: (details) => _onDragStart(
                thumbPosition: details.localPosition,
              ),
              onVerticalDragStart: (details) => _onDragStart(
                thumbPosition: details.localPosition,
              ),
              onHorizontalDragUpdate: (details) => _onDragUpdate(
                constraints,
                thumbPosition: details.localPosition,
              ),
              onVerticalDragUpdate: (details) => _onDragUpdate(
                constraints,
                thumbPosition: details.localPosition,
              ),
              onHorizontalDragEnd: (_) => _onDragEnd(),
              onVerticalDragEnd: (_) => _onDragEnd(),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: _tag.origin.x,
                    top: _tag.origin.y,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _tag.color,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: SizedBox.fromSize(size: _tag.size),
                    ),
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
