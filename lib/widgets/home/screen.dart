import 'package:flutter/material.dart';

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
