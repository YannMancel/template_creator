import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSettingsWidget extends StatelessWidget {
  const TemplateSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const kTabMap = <String, Widget>{
      'Size': TemplateSizeSettingsWidget(),
      'Tags': TagsSettingsWidget(),
    };
    return DefaultTabController(
      length: kTabMap.length,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.inversePrimary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8.0),
              ),
            ),
            child: TabBar(
              tabs: <Widget>[
                for (final text in kTabMap.keys) Tab(text: text),
              ],
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: theme.dialogBackgroundColor,
              child: TabBarView(
                children: <Widget>[
                  for (final view in kTabMap.values) view,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
