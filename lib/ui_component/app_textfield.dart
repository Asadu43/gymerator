import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/utils/app_colors/appColors.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final TextEditingController? controller;
  const AppTextField({Key? key, required this.hintText,  this.icon, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Container(
          // width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.060,
          padding: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.white),
          ),
          child: TextField(
            textAlign: TextAlign.start,
            controller: controller,
            decoration: InputDecoration(
              icon: icon,
                hintText: hintText, border: InputBorder.none, hintStyle: GoogleFonts.barlow(fontSize: 14,color: Colors.grey)),
          ),
        )
      ],
    );
  }
}
