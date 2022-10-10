import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:xpert_iptv/models/user_info.dart';
import 'package:xpert_iptv/providers/database_provider.dart';
import 'package:xpert_iptv/providers/password_provider.dart';
import 'package:xpert_iptv/utils/api_service.dart';
import 'package:xpert_iptv/utils/helper.dart';
import 'package:xpert_iptv/utils/network_client.dart';
import 'package:xpert_iptv/utils/routes.dart';

import '../error/exceptions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final orangeColor = const Color(0xffFCC50A);
  final blackColor = const Color(0xff000000);
  final purpleColor = const Color(0xff6688FF);
  final darkTextColor = const Color(0xff1F1A3D);
  final lightTextColor = const Color(0xff999999);
  final textFieldColor = Color.fromARGB(255, 87, 87, 87);
  final borderColor = const Color(0xffD9D9D9);
  final outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: const BorderSide(color: Colors.transparent, width: 0),
  );
  final _globalKeyLoginForm = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();

  ApiService apiService = ApiService(networkClient: NetworkClient());
  bool showLoader = true;

  Future<void> _submitLoginForm(BuildContext context) async {
    bool isValid = _globalKeyLoginForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      return;
    }
    setState(() {
      showLoader = true;
    });
    _globalKeyLoginForm.currentState!.save();
    try {
      var response = await apiService.login(
        baseUrl: _urlController.text.trim() + '/player_api.php',
        paramsInMap: {
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        response.data['user_info']['name'] = _nameController.text.trim();
        response.data['user_info']['url'] = _urlController.text.trim();
        UserInfo ui = UserInfo.fromJson(response.data['user_info']);
        Helper.saveUserInfo(
          userInfo: ui,
        );
        DatabaseProvider.instance.saveUserInfo(ui);
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      } else {
        setState(() {
          showLoader = false;
        });

        Helper.showSnackBar(
          context: context,
          message: 'Invalid username or password',
        );
      }
    } on RemoteException catch (e) {
      Logger().e(e.dioError);
    }
  }

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  void isLoggedIn() async {
    bool isLogin = await Helper.isLoggedIn();
    if (isLogin) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      setState(() {
        showLoader = false;
      });
    }
    // showLoader = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Form(
          key: _globalKeyLoginForm,
          child: showLoader
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: getLoginForm(context),
                ),
        ),
      ),
    );
  }

  Widget getLoginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 62.h),
        SvgPicture.asset(
          'assets/images/icons/1.svg',
          fit: BoxFit.fill,
          height: 296.h,
          width: 296.w,
        ),
        SizedBox(height: 20.h),
        TextFormField(
          // controller: _nameController,
          controller: _nameController..text = 'Faizan',
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: getTextFieldInputDecoration(
            icon: Icons.account_box,
            hint: 'name',
          ),
          validator: (value) {
            if (value == null) {
              return null;
            }
            if (value.trim().isEmpty) {
              return 'Name is required!';
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        TextFormField(
          // controller: _usernameController,
          controller: _usernameController..text = '2364882095',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: getTextFieldInputDecoration(
            icon: Icons.verified_user,
            hint: 'username',
          ),
          // onSaved: (value) {
          //   _userEmail = value ?? '';
          // },
          validator: (value) {
            if (value == null) {
              return null;
            }
            if (value.trim().isEmpty) {
              return 'username is required!';
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        Consumer<PasswordProvider>(
          builder: (context, passwordProvider, child) => TextFormField(
            obscureText: passwordProvider.isObscure,
            // controller: _passwordController,
            controller: _passwordController..text = '5248589087',
            decoration: getTextFieldInputDecoration(
              icon: Icons.lock,
              hint: '********',
              suffixIcon: IconButton(
                icon: Icon(
                  passwordProvider.isObscure
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () => passwordProvider.toggleIsObscure(),
              ),
            ),
            validator: (value) {
              if (value == null) {
                return null;
              }
              if (value.trim().isEmpty) {
                return 'Password is required!';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 20.h),
        TextFormField(
          // controller: _urlController,
          controller: _urlController..text = 'http://line.extraott-iptv.com:88',
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.next,
          decoration: getTextFieldInputDecoration(
            icon: Icons.account_box,
            hint: 'url',
          ),
          validator: (value) {
            if (value == null) {
              return null;
            }
            if (value.trim().isEmpty) {
              return 'Url is required!';
            }
            return null;
          },
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => _submitLoginForm(context),
            style: TextButton.styleFrom(
              // side: BorderSide(color: borderColor),
              backgroundColor: orangeColor,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration getTextFieldInputDecoration(
      {required String hint, required IconData icon, Widget? suffixIcon}) {
    return InputDecoration(
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 20.w),
          Icon(icon),
          SizedBox(
            height: 15.h,
            child: const VerticalDivider(color: Colors.grey),
          )
        ],
      ),
      suffixIcon: suffixIcon,
      border: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      fillColor: textFieldColor,
      contentPadding: EdgeInsets.symmetric(vertical: 20.h),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
