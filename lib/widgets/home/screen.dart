import 'package:flutter/material.dart';
import './bloc.dart';

class coinData {
  final dynamic current_price;
  final String name;
  final String image;
  coinData(this.current_price, this.name, this.image);
  factory coinData.fromJson(Map<String, dynamic> json) {
    return coinData(json['current_price'], json['name'], json['image']);
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
    print(data);
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
              refreshData();
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
              leading: Image.network(
                object.image,
                width: 48.0,
                height: 48.0,
              ),
              title: Text(object.name),
              subtitle: Text('\$${object.current_price.toStringAsFixed(2)}'),
            );
          },
        ),
      ),
    );
  }
}
