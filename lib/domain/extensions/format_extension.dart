import 'package:template_creator/_features.dart';

extension FormatExt on Format {
  T when<T>({
    required T Function(String) text,
    required T Function(String) image,
  }) {
    return switch (this) {
      TextFormat(:final label) => text(label),
      ImageFormat(:final source) => image(source),
    };
  }
}
