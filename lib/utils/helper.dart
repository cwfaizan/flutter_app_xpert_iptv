import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:xpert_iptv/models/user_info.dart';

class Helper {
  static String baseUrl = '';

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void saveUserInfo({required UserInfo userInfo}) async {
    baseUrl = userInfo.url;
    var box = await Hive.openBox('hiveBox');
    box.put('user_info', userInfo);
  }

  static Future<UserInfo> findUserInfo() async {
    var box = await Hive.openBox('hiveBox');
    return box.get('user_info');
  }

  static void clearUserInfo() async {
    baseUrl = '';
    var box = await Hive.openBox('hiveBox');
    box.delete('user_info');
  }

  static Future<bool> isLoggedIn() async {
    var box = await Hive.openBox('hiveBox');
    if (box.containsKey('user_info')) {
      baseUrl = (box.get('user_info') as UserInfo).url;
      return true;
    }
    return false;
  }

  static void moveToNextScreen(BuildContext context, String path) {
    Navigator.of(context).pushNamed(path);
  }
}
