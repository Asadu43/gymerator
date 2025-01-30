import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceholderDialog extends StatelessWidget {
  const PlaceholderDialog({
    this.icon,
    this.title,
    this.message,
    this.actions = const [],
    this.backgroundColor,
    super.key,
  });

  final Widget? icon;
  final String? title;
  final String? message;
  final List<Widget> actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      backgroundColor: backgroundColor,
      icon: icon,
      surfaceTintColor: backgroundColor,
      title: title == null
          ? null
          : Text(
              title!,
              textAlign: TextAlign.center,
            ),
      titleTextStyle: GoogleFonts.vazirmatn(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
      content: message == null
          ? null
          : Padding(
              padding: EdgeInsets.all(8.h),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.vazirmatn(color: Colors.grey, fontSize: 16.sp),
              ),
            ),
      contentTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
      actions: actions,
    );
  }
}
