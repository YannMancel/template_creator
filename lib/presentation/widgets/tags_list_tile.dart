import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagListTile extends StatelessWidget {
  const TagListTile(
    this.tag, {
    super.key,
  });

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(
            tag.format.when<IconData>(
              text: (_, __) => Icons.text_fields,
              image: (_) => Icons.image,
            ),
          ),
        ),
        Expanded(
          child: Text(
            tag.format.when<String>(
              text: (label, _) => label,
              image: (source) => source,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 150.0,
          height: 120.0,
          child: ActionsWidget(
            onWidthStepUpdate: (step) {
              final logic = context.templateLogic;
              logic.updateTagWidth(tag, width: tag.size.width + step);
            },
            onHeightStepUpdate: (step) {
              final logic = context.templateLogic;
              logic.updateTagHeight(tag, height: tag.size.height + step);
            },
          ),
        ),
      ],
    );
  }
}
