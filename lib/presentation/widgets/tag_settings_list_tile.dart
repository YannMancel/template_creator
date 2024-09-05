import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class TagSettingsListTile extends StatefulWidget {
  const TagSettingsListTile(
    this.tag, {
    super.key,
  });

  final Tag tag;

  @override
  State<TagSettingsListTile> createState() => _TagSettingsListTileState();
}

class _TagSettingsListTileState extends State<TagSettingsListTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.tag.format.when<String>(
        text: (label, _, __) => label,
        image: (source) => source,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: MenuAnchor(
            menuChildren: <Widget>[
              MenuItemButton(
                child: const Icon(Icons.text_fields),
                onPressed: () {
                  final logic = context.templateLogic;
                  logic.convertToTextFormat(widget.tag);
                },
              ),
              MenuItemButton(
                child: const Icon(Icons.image),
                onPressed: () {
                  final logic = context.templateLogic;
                  logic.convertToImageFormat(widget.tag);
                },
              ),
            ],
            builder: (_, controller, __) => IconButton.outlined(
              onPressed: () {
                controller.isOpen ? controller.close() : controller.open();
              },
              icon: Icon(
                widget.tag.format.when<IconData>(
                  text: (_, __, ___) => Icons.text_fields,
                  image: (_) => Icons.image,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: _controller,
            onEditingComplete: () {
              final logic = context.templateLogic;
              widget.tag.format.when<void>(
                text: (_, __, ___) {
                  logic.updateTagLabel(widget.tag, label: _controller.text);
                },
                image: (_) {
                  logic.updateTagSource(widget.tag, source: _controller.text);
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 150.0,
          height: 120.0,
          child: SizeButtons(
            onWidthStepUpdate: (step) {
              final logic = context.templateLogic;
              logic.updateTagWidth(
                widget.tag,
                width: widget.tag.size.width + step,
              );
            },
            onHeightStepUpdate: (step) {
              final logic = context.templateLogic;
              logic.updateTagHeight(
                widget.tag,
                height: widget.tag.size.height + step,
              );
            },
          ),
        ),
      ],
    );
  }
}
