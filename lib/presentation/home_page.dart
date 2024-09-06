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
    final isSmallDevice = context.isSmallDevice;
    const kTemplateView = Center(
      child: TemplateCard(),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isSmallDevice
          ? kTemplateView
          : const Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: kTemplateView,
                ),
                VerticalDivider(width: 1.0),
                Expanded(
                  flex: 2,
                  child: TemplateSettingsWidget(),
                ),
              ],
            ),
      floatingActionButton: isSmallDevice
          ? FloatingActionButton(
              onPressed: () async {
                await TemplateSettingsBottomSheet.show(context);
              },
              child: const Icon(Icons.edit),
            )
          : null,
    );
  }
}
