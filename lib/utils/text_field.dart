import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/font.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function onTap;
  final String hintText;
  final FocusNode? textFiledNode;
  final bool? isEmail;
  final Function? onChange;


  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.textFiledNode,
    this.isEmail, required this.onTap, this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: CColor.black,
              fontSize: 14,
              fontFamily: Font.poppins,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            key: key,
            focusNode: textFiledNode,
            controller: controller,
            onChanged: (value){
              onChange?.call(value);
            },
            onFieldSubmitted: (value) {
              onTap.call();
            },
            textCapitalization: (isEmail == true)
                ? TextCapitalization.none
                : TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            style: TextStyle(
              fontFamily: Font.poppins,
              color: CColor.black,
              fontWeight: FontWeight.w300,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              counterStyle:  TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w300,
                color: CColor.black,
              ),
              filled: true,
              fillColor: CColor.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              isCollapsed: true,
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: Font.poppins,
                color: CColor.grayText,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              // isDense: true,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CColor.dividerLine,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CColor.dividerLine, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
