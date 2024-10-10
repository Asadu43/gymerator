import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Image.asset(icon),
          const SizedBox(width: 10),
          Text(
            '$label : ',
            maxLines: 1,overflow: TextOverflow.ellipsis,
            style: GoogleFonts.vazirmatn(fontSize: 8.sp),
          ),
          Flexible(
            child: Text(
              value,
              maxLines: 1,overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(fontSize: 8.sp),
            ),
          ),
        ],
      ),
    );
  }
}
