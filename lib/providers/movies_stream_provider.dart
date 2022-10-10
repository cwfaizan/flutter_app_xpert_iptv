import 'package:flutter/foundation.dart';
import 'package:xpert_iptv/models/movies_stream.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/network_client.dart';

import '../models/user_info.dart';
import '../utils/helper.dart';

class MoviesStreamProvider with ChangeNotifier {
  ApiService api = ApiService(networkClient: NetworkClient());
  List<MoviesStream> _moviesStreamList = [];
  List<MoviesStream> _filteredMoviesStreamList = [];
  String username = '';
  String password = '';

  List<MoviesStream> get moviesStreamList {
    return _filteredMoviesStreamList;
  }

  Future<void> loadMoviesStreamList(String categoryId) async {
    UserInfo ui = await Helper.findUserInfo();
    final response = await api.get(
      baseUrl: ui.url + '/player_api.php',
      paramsInMap: {
        'username': ui.username,
        'password': ui.password,
        'action': 'get_vod_streams',
        'category_id': categoryId,
      },
    );
    _moviesStreamList =
        (response.data as List).map((e) => MoviesStream.fromJson(e)).toList();
    _filteredMoviesStreamList = [..._moviesStreamList];
    username = ui.username;
    password = ui.password;
    notifyListeners();
  }

  void search(String searchQuery) {
    if (searchQuery.isEmpty) _filteredMoviesStreamList = [..._moviesStreamList];
    _filteredMoviesStreamList = [
      ..._moviesStreamList.where(
          (e) => e.name.toLowerCase().contains(searchQuery.toLowerCase()))
    ];
    notifyListeners();
  }
}
