import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: TemplateCard(),
            ),
          ),
          SizedBox(
            height: 300.0,
            child: ConfigurationWidget(),
          ),
        ],
      ),
    );
  }
}
