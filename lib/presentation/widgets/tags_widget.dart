import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = context.templateLogic;
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
              padding: const EdgeInsets.only(bottom: 64.0),
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
