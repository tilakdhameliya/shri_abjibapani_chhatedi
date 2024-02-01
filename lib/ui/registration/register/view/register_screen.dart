import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/color.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/date_field.dart';
import '../../../../utils/font.dart';
import '../../../../utils/text_field.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
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

  _header(RegisterController logic) {
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
                "Registration",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _centerView(RegisterController logic) {
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
                "NEXT",
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),)
        ],
      ),
    );
  }
}
