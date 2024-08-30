import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

void main() => runApp(const MyApp());

const kAppName = 'Template Creator';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TagsLogicWidget(
        logic: TagsLogicImpl(),
        child: const HomePage(title: kAppName),
      ),
    );
  }
}
