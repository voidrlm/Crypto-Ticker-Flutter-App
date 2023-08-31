import '../../services/rest-api-manager.dart';

class homeScreenBloc {
  fetchCoinData() async {
    final response = await fetchData();
    return response;
  }
}
