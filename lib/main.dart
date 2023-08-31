import 'package:flutter/material.dart';
import './widgets/home/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(112, 0, 146, 44)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Cryptocurrencies"),
    );
  }
}
