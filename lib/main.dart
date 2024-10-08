import 'package:flutter/material.dart';
import 'package:template_creator/_features.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateLogicWidget(
      logic: TemplateLogicByValueNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(title: kAppName),
      ),
    );
  }
}
