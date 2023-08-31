import 'package:dio/dio.dart';

Future<List> fetchData() async {
  final dio = Dio();
  try {
    final response = await dio.get(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}
