import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final Color? color;
  final Color? prefixIconColor;
  final TextStyle? fieldTextStyle;
  const AppTextField(
      {Key? key,
      required this.hintText,
      this.icon,
      this.controller,
      this.prefixIconColor,
      this.fieldTextStyle,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.07,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color ?? Colors.white),
      ),
      child: TextField(
        textAlign: TextAlign.start,
        controller: controller,
        style: fieldTextStyle ?? const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: icon,
            prefixIconColor: prefixIconColor ?? Colors.white,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: GoogleFonts.barlow(fontSize: 14, color: Colors.grey)),
      ),
    );
  }
}
