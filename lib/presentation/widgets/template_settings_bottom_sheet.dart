import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TemplateSettingsBottomSheet extends StatelessWidget {
  const TemplateSettingsBottomSheet._({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  static Future<void> show(
    BuildContext context, {
    Key? key,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        expand: false,
        builder: (_, scrollController) => TemplateSettingsBottomSheet._(
          key: key,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: const <Widget>[
        SliverFillRemaining(
          child: TemplateSettingsWidget(),
        ),
      ],
    );
  }
}
