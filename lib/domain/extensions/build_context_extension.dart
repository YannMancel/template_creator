import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

extension BuildContextExt on BuildContext {
  TemplateLogic get templateLogic => TemplateLogicWidget.of(this).logic;
}
