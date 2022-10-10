import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xpert_iptv/models/tv_category.dart';
import 'package:xpert_iptv/models/user_info.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/helper.dart';
import 'package:xpert_iptv/utils/network_client.dart';

class TvCategoryProvider with ChangeNotifier {
  ApiService api = ApiService(networkClient: NetworkClient());
  List<TvCategory> _tvCategoryList = [];
  List<TvCategory> _filteredTvCategoryList = [];

  List<TvCategory> get tvCategoryList {
    return _filteredTvCategoryList;
  }

  Future<void> loadCategories(String action) async {
    try {
      UserInfo ui = await Helper.findUserInfo();
      final response = await api.get(
        baseUrl: ui.url + '/player_api.php',
        paramsInMap: {
          'username': ui.username,
          'password': ui.password,
          'action': action,
        },
      );
      _tvCategoryList =
          (response.data as List).map((e) => TvCategory.fromJson(e)).toList();
      _filteredTvCategoryList = [..._tvCategoryList];
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
    if (searchQuery.isEmpty) _filteredTvCategoryList = _tvCategoryList;
    _filteredTvCategoryList = [
      ..._tvCategoryList.where((e) =>
          e.categoryName.toLowerCase().contains(searchQuery.toLowerCase()))
    ];
    notifyListeners();
  }
}
