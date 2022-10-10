import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/providers/account_provider.dart';

import '../models/user_info.dart';

class AccountCard extends StatelessWidget {
  final UserInfo userInfo;
  const AccountCard({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: REdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userInfo.name,
                  style: GoogleFonts.dmSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  userInfo.username,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff8F92A1),
                  ),
                ),
              ],
            ),
            // const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<AccountProvider>(context, listen: false)
                    .delete(context, userInfo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
