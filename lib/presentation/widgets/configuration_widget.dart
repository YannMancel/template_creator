import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class ConfigurationWidget extends StatelessWidget {
  const ConfigurationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const kTabMap = <String, Widget>{
      'Size': TemplateSizeWidget(),
      'Tags': TagsWidget(),
    };
    return DefaultTabController(
      length: kTabMap.length,
      child: Column(
        children: <Widget>[
          ColoredBox(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: TabBar(
              tabs: <Widget>[
                for (final text in kTabMap.keys) Tab(text: text),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                for (final view in kTabMap.values) view,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
