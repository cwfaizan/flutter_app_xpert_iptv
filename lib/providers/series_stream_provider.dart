import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/network_client.dart';

import '../models/series_stream.dart';
import '../models/user_info.dart';
import '../utils/helper.dart';

class SeriesStreamProvider with ChangeNotifier {
  ApiService api = ApiService(networkClient: NetworkClient());
  List<SeriesStream> _seriesStreamList = [];
  List<SeriesStream> _filteredSeriesStreamList = [];
  String username = '';
  String password = '';

  List<SeriesStream> get seriesStreamList {
    return _filteredSeriesStreamList;
  }

  Future<void> loadSeriesStreamList(String categoryId) async {
    try {
      UserInfo ui = await Helper.findUserInfo();
      final response = await api.get(
        baseUrl: ui.url + '/player_api.php',
        paramsInMap: {
          'username': ui.username,
          'password': ui.password,
          'action': 'get_series',
          'category_id': categoryId,
        },
      );
      _seriesStreamList =
          (response.data as List).map((e) => SeriesStream.fromJson(e)).toList();
      _filteredSeriesStreamList = _seriesStreamList;
      username = ui.username;
      password = ui.password;
      notifyListeners();
    } on DioError catch (e) {
      stderr.write(e.message);
      // Helper.showSnackBar(
      //   context: context,
      //   message: 'Invalid username or password',
      // );
    }
  }

  void search(String searchQuery) {
    if (searchQuery.isEmpty) _filteredSeriesStreamList = [..._seriesStreamList];
    _filteredSeriesStreamList = [
      ..._seriesStreamList.where(
          (e) => e.name.toLowerCase().contains(searchQuery.toLowerCase()))
    ];
    notifyListeners();
  }
}
