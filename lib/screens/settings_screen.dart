import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/components/account_card.dart';
import 'package:xpert_iptv/providers/account_provider.dart';
import 'package:xpert_iptv/utils/helper.dart';

import '../utils/routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AccountProvider>(context, listen: false).update(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Users',
                    style: GoogleFonts.dmSans(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.power_settings_new),
                    onPressed: () {
                      Helper.clearUserInfo();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginScreen,
                        (r) => false,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Helper.clearUserInfo();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginScreen,
                        (r) => false,
                      );
                    },
                  ),
                ],
              ),
              Consumer<AccountProvider>(
                builder: (context, ap, child) {
                  return ap.userInfos.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: ap.userInfos.length,
                            itemBuilder: (context, index) =>
                                AccountCard(userInfo: ap.userInfos[index]),
                          ),
                        )
                      : const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
