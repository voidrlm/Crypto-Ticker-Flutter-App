import 'package:flutter/material.dart';
import './bloc.dart';

class coinData {
  final dynamic current_price;
  final String name;
  coinData(this.current_price, this.name);
  factory coinData.fromJson(Map<String, dynamic> json) {
    return coinData(json['current_price'], json['name']);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> coins = [];
  @override
  void initState() {
    refreshData();
    super.initState();
  }

  Future<void> refreshData() async {
    final homeScreenBloc bloc = homeScreenBloc();
    final data = await bloc.fetchCoinData();

    setState(() {
      coins = data.map((item) => coinData.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenBloc bloc = homeScreenBloc();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              bloc.fetchCoinData();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
          itemCount: coins.length,
          itemBuilder: (context, index) {
            final coinData object = coins[index];
            return ListTile(
              title: Text(object.name),
              subtitle: Text('\$${object.current_price.toStringAsFixed(2)}'),
            );
          },
        ),
      ),
    );
  }
}
