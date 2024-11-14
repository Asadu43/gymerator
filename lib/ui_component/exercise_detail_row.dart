import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class ExerciseDetailRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const ExerciseDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Image.asset(icon),
           SizedBox(width: 10.w),
          Text(
            '$label : ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.vazirmatn(fontSize: 10.sp),
          ),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
