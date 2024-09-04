import 'package:flutter/material.dart';

@immutable
sealed class Format {
  const Format();
}

@immutable
final class TextFormat extends Format {
  const TextFormat({
    required this.label,
    this.style = const TextStyle(
      color: Colors.black,
      fontSize: 8.0,
      fontWeight: FontWeight.normal,
    ),
  });

  final String label;
  final TextStyle style;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is TextFormat &&
            label == other.label &&
            style == other.style);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        label,
        style,
      ],
    );
  }
}

@immutable
final class ImageFormat extends Format {
  const ImageFormat({required this.source});

  final String source;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            other is ImageFormat &&
            source == other.source);
  }

  @override
  int get hashCode {
    return Object.hashAll(
      <Object?>[
        runtimeType,
        source,
      ],
    );
  }
}
