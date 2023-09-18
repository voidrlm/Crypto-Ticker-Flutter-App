import '../../services/rest-api-manager.dart';

class homeScreenBloc {
  Future<List> fetchCoinData() async {
    final response = await fetchData();
    return response;
  }
}
