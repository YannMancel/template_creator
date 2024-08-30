import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Size _templateSize;

  set _templateWidthByStep(double step) {
    setState(() {
      _templateSize = Size(_templateSize.width + step, _templateSize.height);
    });
  }

  set _templateHeightByStep(double step) {
    setState(() {
      _templateSize = Size(_templateSize.width, _templateSize.height + step);
    });
  }

  @override
  void initState() {
    super.initState();
    _templateSize = const Size.square(300);
  }

  @override
  Widget build(BuildContext context) {
    final inversePrimaryColor = Theme.of(context).colorScheme.inversePrimary;
    return TagsLogicWidget(
      logic: TagsLogicImpl(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: inversePrimaryColor,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Center(
                    child: TemplateWidget(size: _templateSize),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Add area'),
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: inversePrimaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ActionOnTemplateSize(
                    title: 'Width',
                    onPressedDecrease: () => _templateWidthByStep = -10.0,
                    onPressedIncrease: () => _templateWidthByStep = 10.0,
                  ),
                  ActionOnTemplateSize(
                    title: 'Height',
                    onPressedDecrease: () => _templateHeightByStep = -10.0,
                    onPressedIncrease: () => _templateHeightByStep = 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionOnTemplateSize extends StatelessWidget {
  const ActionOnTemplateSize({
    super.key,
    required this.title,
    required this.onPressedDecrease,
    required this.onPressedIncrease,
  });

  final String title;
  final VoidCallback onPressedDecrease;
  final VoidCallback onPressedIncrease;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: OverflowBar(
        children: <Widget>[
          IconButton(
            onPressed: onPressedDecrease,
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: onPressedIncrease,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
