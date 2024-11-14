import 'package:flutter/material.dart'
    show BuildContext, Colors, ScaffoldMessenger, SnackBar, Text;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


enum SnackBarType { success, failed }

void showSnackBar(BuildContext context, String message,
    {SnackBarType type = SnackBarType.failed}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: GoogleFonts.vazirmatn(color: Colors.white, fontSize: 16.sp),
    ),
    backgroundColor:
        type == SnackBarType.failed ? Colors.red : Colors.green.shade700,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
