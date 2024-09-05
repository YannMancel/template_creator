import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagWidget extends StatelessWidget {
  const TagWidget(this.tag, {super.key});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: tag.size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tag.stateColor,
          border: tag.border,
          borderRadius: tag.borderRadius,
          image: tag.format.when<DecorationImage?>(
            text: (_, __, ___) => null,
            image: (source) => DecorationImage(
              colorFilter: tag.when<ColorFilter?>(
                idle: () => null,
                selected: () => ColorFilter.mode(
                  tag.stateColor,
                  BlendMode.modulate,
                ),
              ),
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
    );
  }
}
