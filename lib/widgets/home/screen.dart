import 'package:flutter/material.dart';
import './bloc.dart';

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
  @override
  void initState() {
    final homeScreenBloc bloc = homeScreenBloc();
    bloc.fetchCoinData();
    super.initState();
  }

  Future<void> _refreshData() async {
    // Simulate loading new data

    final homeScreenBloc bloc = homeScreenBloc();
    await bloc.fetchCoinData();
  }

  final List<CryptoPrice> cryptoPrices = [
    CryptoPrice(name: 'Bitcoin', price: 48000),
    CryptoPrice(name: 'Ethereum', price: 3200),
    CryptoPrice(name: 'Cardano', price: 2.5),
    CryptoPrice(name: 'Solana', price: 150),
    CryptoPrice(name: 'Binance Coin', price: 400),
  ];
  @override
  Widget build(BuildContext context) {
    final homeScreenBloc bloc = homeScreenBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView.builder(
          itemCount: cryptoPrices.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.warning_amber),
                title: Text(cryptoPrices[index].name),
                subtitle:
                    Text('\$${cryptoPrices[index].price.toStringAsFixed(2)}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
