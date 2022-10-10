import 'package:flutter/foundation.dart';
import 'package:xpert_iptv/models/live_tv_stream.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/network_client.dart';

import '../models/user_info.dart';
import '../utils/helper.dart';

class LiveTvStreamProvider with ChangeNotifier {
  ApiService api = ApiService(networkClient: NetworkClient());
  List<LiveTvStream> _liveTvStreamList = [];
  List<LiveTvStream> _filteredLiveTvStreamList = [];
  String username = '';
  String password = '';

  List<LiveTvStream> get liveTvStreamList {
    return _filteredLiveTvStreamList;
  }

  Future<void> loadLiveTvStreamList(String categoryId) async {
    UserInfo ui = await Helper.findUserInfo();
    final response = await api.get(
      baseUrl: ui.url + '/player_api.php',
      paramsInMap: {
        'username': ui.username,
        'password': ui.password,
        'action': 'get_live_streams',
        'category_id': categoryId,
      },
    );
    _liveTvStreamList =
        (response.data as List).map((e) => LiveTvStream.fromJson(e)).toList();
    _filteredLiveTvStreamList = [..._liveTvStreamList];
    username = ui.username;
    password = ui.password;
    notifyListeners();
  }

  void search(String searchQuery) {
    if (searchQuery.isEmpty) _filteredLiveTvStreamList = [..._liveTvStreamList];
    _filteredLiveTvStreamList = [
      ..._liveTvStreamList.where(
          (e) => e.name.toLowerCase().contains(searchQuery.toLowerCase()))
    ];
    notifyListeners();
  }
}
