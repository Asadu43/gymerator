import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextField extends StatefulWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  final Color? color;
  final Color? cursorColor;
  final Color? prefixIconColor;
  final TextStyle? fieldTextStyle;
  final TextInputType? textInputType;
  final Function(String?)? onChanged;
  final bool? obscureText; // Add this to make obscureText optional

  const AppTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.prefixIconColor,
    this.fieldTextStyle,
    this.textInputType,
    this.color,
    this.onChanged,
    this.cursorColor,
    this.obscureText, // Accept the obscureText flag
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscurePassword; // Initialize the obscurePassword flag dynamically

  @override
  void initState() {
    super.initState();
    obscurePassword = widget.obscureText ??
        false; // Set default to false if obscureText is null
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h, // Set height using ScreenUtil
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 12.w), // Adjust padding using ScreenUtil
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r), // Adjust border radius
        border: Border.all(color: widget.color ?? Colors.white),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        cursorColor: widget.cursorColor ?? Colors.white,
        controller: widget.controller,
        style: widget.fieldTextStyle ??
            GoogleFonts.vazirmatn(color: Colors.white, fontSize: 14.sp), // Font size with ScreenUtil
        keyboardType: widget.textInputType ?? TextInputType.text,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText == true
            ? obscurePassword // Use the flag for obscuring text
            : false,
        decoration: InputDecoration(
          prefixIcon: widget.icon,
          prefixIconColor: widget.prefixIconColor ?? Colors.white,
          hintText: widget.hintText,
          border: InputBorder.none,
          suffixIcon: widget.obscureText == true
              ? IconButton(
            icon: Icon(
              obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
              size: 20.sp, // Adjust icon size with ScreenUtil
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          )
              : null,
          hintStyle: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.grey), // Adjust hint text size with ScreenUtil
        ),
      ),
    );
  }

}
