import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    super.key,
    required this.onUpdatedWidthByStep,
    required this.onUpdatedHeightByStep,
  });

  final ValueSetter<double> onUpdatedWidthByStep;
  final ValueSetter<double> onUpdatedHeightByStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton.outlined(
              onPressed: () => onUpdatedWidthByStep(-10.0),
              icon: const Icon(Icons.remove),
            ),
            const Icon(Icons.swap_horiz),
            IconButton.outlined(
              onPressed: () => onUpdatedWidthByStep(10.0),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton.outlined(
              onPressed: () => onUpdatedHeightByStep(-10.0),
              icon: const Icon(Icons.remove),
            ),
            const Icon(Icons.swap_vert),
            IconButton.outlined(
              onPressed: () => onUpdatedHeightByStep(10.0),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
