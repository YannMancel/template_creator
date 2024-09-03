import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = TemplateLogicWidget.of(context).logic;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: logic.template,
          builder: (_, template, __) {
            if (template.tags.isEmpty) {
              return const Center(
                child: Text('No tags'),
              );
            }

            final sortedTags = template.tags.reversedById;
            return ListView.separated(
              padding: const EdgeInsets.only(bottom: 56.0),
              itemCount: sortedTags.length,
              itemBuilder: (_, index) {
                final tag = sortedTags[index];
                return TagListTile(tag);
              },
              separatorBuilder: (_, __) => const Divider(),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: logic.addTag,
            icon: const Icon(Icons.add),
            label: const Text('Tag'),
          ),
        ),
      ],
    );
  }
}

class TagListTile extends StatelessWidget {
  const TagListTile(
    this.tag, {
    super.key,
  });

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    final logic = TemplateLogicWidget.of(context).logic;
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(
            tag.format.when<IconData>(
              text: (_) => Icons.text_fields,
              image: (_) => Icons.image,
            ),
          ),
        ),
        Expanded(
          child: Text(
            tag.format.when<String>(
              text: (label) => label,
              image: (source) => source,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 150.0,
          height: 120.0,
          child: ActionsWidget(
            onUpdatedWidthByStep: (step) {
              logic.updateTagWidth(tag, width: tag.size.width + step);
            },
            onUpdatedHeightByStep: (step) {
              logic.updateTagHeight(tag, height: tag.size.height + step);
            },
          ),
        ),
      ],
    );
  }
}
