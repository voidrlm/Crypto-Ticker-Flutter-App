import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class CryptoPrice {
  final String name;
  final double price;

  CryptoPrice({required this.name, required this.price});
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CryptoPrice> cryptoPrices = [
    CryptoPrice(name: 'Bitcoin', price: 48000),
    CryptoPrice(name: 'Ethereum', price: 3200),
    CryptoPrice(name: 'Cardano', price: 2.5),
    CryptoPrice(name: 'Solana', price: 150),
    CryptoPrice(name: 'Binance Coin', price: 400),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: cryptoPrices.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(cryptoPrices[index].name),
            subtitle: Text('\$${cryptoPrices[index].price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
