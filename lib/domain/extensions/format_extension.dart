import 'package:flutter/widgets.dart';
import 'package:template_creator/_features.dart';

extension FormatExt on Format {
  T when<T>({
    required T Function(String, Alignment, TextStyle) text,
    required T Function(String) image,
  }) {
    return switch (this) {
      TextFormat(:final label, :final alignment, :final style) =>
        text(label, alignment, style),
      ImageFormat(:final source) => image(source),
    };
  }
}
