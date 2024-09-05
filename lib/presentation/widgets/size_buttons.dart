import 'package:flutter/material.dart';

class SizeButtons extends StatelessWidget {
  const SizeButtons({
    super.key,
    required this.onWidthStepUpdate,
    required this.onHeightStepUpdate,
  });

  final ValueSetter<double> onWidthStepUpdate;
  final ValueSetter<double> onHeightStepUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton.outlined(
              onPressed: () => onWidthStepUpdate(-10.0),
              icon: const Icon(Icons.remove),
            ),
            const Icon(Icons.swap_horiz),
            IconButton.outlined(
              onPressed: () => onWidthStepUpdate(10.0),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton.outlined(
              onPressed: () => onHeightStepUpdate(-10.0),
              icon: const Icon(Icons.remove),
            ),
            const Icon(Icons.swap_vert),
            IconButton.outlined(
              onPressed: () => onHeightStepUpdate(10.0),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
