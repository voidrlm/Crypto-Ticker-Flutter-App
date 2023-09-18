import 'package:flutter/material.dart';
import './bloc.dart';

class coinData {
  final dynamic current_price;
  final String name;
  final String image;
  final dynamic market_cap;
  final dynamic total_volume;
  final dynamic high_24h;
  final dynamic low_24h;
  final dynamic price_change_percentage_24h;
  final dynamic price_change_24h;

  coinData(
      this.current_price,
      this.name,
      this.image,
      this.market_cap,
      this.total_volume,
      this.high_24h,
      this.low_24h,
      this.price_change_percentage_24h,
      this.price_change_24h);
  factory coinData.fromJson(Map<String, dynamic> json) {
    return coinData(
      json['current_price'],
      json['name'],
      json['image'],
      json['market_cap'],
      json['total_volume'],
      json['high_24h'],
      json['low_24h'],
      json['price_change_percentage_24h'],
      json['price_change_24h'],
    );
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
              onTap: () {
                _showDetailedInformation(context,
                    coins[index]); // Call the function to show the bottom sheet
              },
            );
          },
        ),
      ),
    );
  }

  void _showDetailedInformation(BuildContext context, coin) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          // Customize the content of your bottom sheet here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(
                coin.image,
                width: 48.0,
                height: 48.0,
              ),
              Text(
                coin.name,
                style: TextStyle(fontSize: 24.0),
              ),
              ListTile(
                title: const Text('Current Price'),
                subtitle: Text('\$${coin.current_price.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Market Cap'),
                subtitle: Text('\$${coin.market_cap.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Total Volume'),
                subtitle: Text('\$${coin.total_volume.toStringAsFixed(2)}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
