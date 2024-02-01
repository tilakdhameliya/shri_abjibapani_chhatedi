import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/ui/registration/login/controller/login_controller.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/date_field.dart';
import 'package:satsang/utils/text_field.dart';

import '../../../../utils/font.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (logic) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            ),
          ),
        );
      },
    );
  }

  _header(LoginController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 65,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              offset: const Offset(0.0, 1.5),
              blurRadius: 1,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Login",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.registrationScreen);
            },
            child: Text(
              "Register",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _centerView(LoginController logic) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          SvgPicture.asset(
            "assets/image/date.svg",
            height: 80,
          ),
          const SizedBox(height: 15),
          DateField(
              title: "Date of Birth",
              startController: Constant.birthDateController,
              hintText: "Select Date"),
          const SizedBox(height: 15),
          CustomTextField(
              title: "Mobile No",
              controller: Constant.mobileNoController,
              hintText: "9898523657",
              onTap: () {}),
          const SizedBox(height: 15),
          CustomTextField(
              title: "Unique Id",
              controller: Constant.mobileNoController,
              hintText: "T0001 OR 0034567",
              onTap: () {}),
          const SizedBox(height: 30),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: CColor.theme),
              child: Text(
                "SIGN IN",
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ))
        ],
      ),
    );
  }
}
