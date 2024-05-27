import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class PlaceholderDialog extends StatelessWidget {
  const PlaceholderDialog({
    this.icon,
    this.title,
    this.message,
    this.actions = const [],
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final Widget? icon;
  final String? title;
  final String? message;
  final List<Widget> actions;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message!,
                textAlign: TextAlign.center,
              ),
            ),
      contentTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 8.0,
      actions: actions,
    );
  }
}
