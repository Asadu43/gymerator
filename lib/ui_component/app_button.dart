import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h, // Set height with ScreenUtil
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 1),
            blurRadius: 5.0,
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffB14501),
            Color(0xff3F710D),
          ],
        ),
        borderRadius: BorderRadius.circular(50.r), // Adjust border radius
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r), // Adjust radius
            ),
          ),
          minimumSize: WidgetStateProperty.all(
            Size(1.sw, 60.h), // Full width and adjusted height
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.vazirmatn(
            fontSize: 20.sp, // Set font size with ScreenUtil
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}
