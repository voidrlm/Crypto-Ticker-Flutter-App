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
  bool isLoading = false;
  @override
  void initState() {
    refreshData();
    super.initState();
  }

  Future<void> refreshData() async {
    final homeScreenBloc bloc = homeScreenBloc();

    setState(() {
      isLoading = true;
    });
    final data = await bloc.fetchCoinData();
    setState(() {
      coins = data.map((item) => coinData.fromJson(item)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          isLoading
              ? const Padding(
                  padding:
                      EdgeInsets.only(right: 16.0), // Add right padding here
                  child: SizedBox(
                      width: 18.0, // Adjust the width here
                      height: 18.0, // Adjust the height here
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        strokeWidth: 2.0,
                      )))
              : IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    refreshData();
                  },
                ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: coins.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.error_outline,
                      size: 100.0,
                      color: Colors.red,
                    ),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        refreshData();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
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
                    subtitle:
                        Text('\$${object.current_price.toStringAsFixed(2)}'),
                    trailing: Text(
                      '${object.price_change_percentage_24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: object.price_change_percentage_24h
                                      .toStringAsFixed(2)[0] ==
                                  '-'
                              ? Colors.red
                              : Colors.green),
                    ),
                    onTap: () {
                      _showDetailedInformation(
                          context,
                          coins[
                              index]); // Call the function to show the bottom sheet
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
          padding: const EdgeInsets.all(16.0),
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
                style: const TextStyle(fontSize: 24.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(16.0), // Add your desired padding here
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Horizontal alignment
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('\$${coin.current_price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20.0,
                        )),
                    Text(
                      '${coin.price_change_percentage_24h.toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: coin.price_change_percentage_24h
                                      .toStringAsFixed(2)[0] ==
                                  '-'
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('24 Hour Price Change'),
                subtitle: Text('\$${coin.price_change_24h.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Today High'),
                subtitle: Text('\$${coin.high_24h.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Today Low'),
                subtitle: Text('\$${coin.low_24h.toStringAsFixed(2)}'),
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
