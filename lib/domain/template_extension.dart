import 'dart:ui';

import 'package:template_creator/_features.dart';

extension TemplateExt on Template {
  Template copyWith({
    Size? size,
    List<Tag>? tags,
  }) {
    return Template(
      size: size ?? this.size,
      tags: tags ?? this.tags,
    );
  }
}
