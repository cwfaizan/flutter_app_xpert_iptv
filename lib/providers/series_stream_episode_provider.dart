import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xpert_iptv/models/series_stream_episode.dart';
import 'package:xpert_iptv/models/user_info.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/helper.dart';
import 'package:xpert_iptv/utils/network_client.dart';

class SeriesStreamEpisodeProvider with ChangeNotifier {
  ApiService api = ApiService(networkClient: NetworkClient());
  int _seasonsCount = 0;
  List<SeriesStreamEpisode> seriesStreamEpisodeList = [];
  List<SeriesStreamEpisode> filteredSeriesStreamEpisodeList = [];
  String username = '';
  String password = '';

  int get seasonsCount {
    return _seasonsCount;
  }

  set seasonsCount(int _seasonsCount) {
    this._seasonsCount = _seasonsCount;
  }

  Future<void> loadSeriesStreamEpisodeList(dynamic seriesId) async {
    try {
      UserInfo ui = await Helper.findUserInfo();
      final response = await api.get(
        baseUrl: ui.url + '/player_api.php',
        paramsInMap: {
          'username': ui.username,
          'password': ui.password,
          'action': 'get_series_info',
          'series_id': seriesId,
        },
      );
      _seasonsCount = response.data['episodes'].keys.length;

      for (int i = 1; i <= seasonsCount; i++) {
        seriesStreamEpisodeList
            .addAll((response.data['episodes']['$i'] as List).map((e) {
          e['seasons_no'] = i;
          return SeriesStreamEpisode.fromJson(e);
        }).toList());
      }
      filteredSeriesStreamEpisodeList =
          seriesStreamEpisodeList.where((e) => e.seasonsNo == 1).toList();
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

  void getSeriesStreamEpisodeList(int seasonsNo) {
    filteredSeriesStreamEpisodeList =
        seriesStreamEpisodeList.where((e) => e.seasonsNo == seasonsNo).toList();
    notifyListeners();
  }
}
