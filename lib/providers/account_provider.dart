import 'package:flutter/cupertino.dart';
import 'package:xpert_iptv/models/user_info.dart';
import 'package:xpert_iptv/utils/routes.dart';

import '../utils/helper.dart';
import 'database_provider.dart';

class AccountProvider with ChangeNotifier {
  List<UserInfo> userInfos = [];

  void update(BuildContext context) async {
    userInfos = await DatabaseProvider.instance.getUsersInfo();
    if (userInfos.isEmpty) {
      logout(context);
    } else {
      notifyListeners();
    }
  }

  Future<void> delete(BuildContext context, UserInfo ui) async {
    userInfos.remove(ui);
    await DatabaseProvider.instance.deleteUserInfo(ui);
    if (userInfos.isEmpty) {
      logout(context);
    } else {
      notifyListeners();
    }
  }

  void logout(BuildContext context) {
    Helper.clearUserInfo();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginScreen,
      (r) => false,
    );
  }
}
