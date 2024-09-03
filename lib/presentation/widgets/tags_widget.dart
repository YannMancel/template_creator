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
            return template.tags.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 56.0),
                    itemCount: template.tags.length,
                    itemBuilder: (_, index) {
                      final tag = template.tags[index];
                      return ListTile(
                        leading: Icon(
                          tag.format.when<IconData>(
                            text: (_) => Icons.text_fields,
                            image: (_) => Icons.image,
                          ),
                        ),
                        title: Text(
                          tag.format.when<String>(
                            text: (label) => label,
                            image: (source) => source,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No tags'),
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
