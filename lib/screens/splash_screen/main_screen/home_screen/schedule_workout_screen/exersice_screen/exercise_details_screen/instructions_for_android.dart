import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/utils/nav/nav.dart';

class InstructionsForAndroidScreen extends StatelessWidget {
  const InstructionsForAndroidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Nav.pop(context);
          },
        ),
        title: Text(
          'Instructions for Android',
          style: GoogleFonts.vazirmatn(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instructions for Android Users to Fetch Health Data',
                style: GoogleFonts.vazirmatn(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.h),
              _buildInstructionSection(
                number: '1',
                title: 'Download Required Apps',
                content: [
                  'The user must install the Health Connect app.',
                  'The user must install the Google Fit app.',
                ],
              ),
              SizedBox(height: 20.h),
              _buildInstructionSection(
                number: '2',
                title: 'Ensure a Compatible Smartwatch',
                content: [
                  'The user must have a good-quality Android smartwatch, such as Samsung, Vivo, etc.',
                ],
              ),
              SizedBox(height: 20.h),
              _buildInstructionSection(
                number: '3',
                title: 'Connect the Smartwatch (Example: Samsung Watch)',
                content: [
                  'The user must connect their Samsung Watch to the Samsung Health app.',
                ],
              ),
              SizedBox(height: 20.h),
              _buildInstructionSection(
                number: '4',
                title: 'Sync Samsung Health with Google Fit',
                content: [
                  'The user must sync Samsung Health with Google Fit to enable data sharing.',
                ],
              ),
              SizedBox(height: 20.h),
              _buildInstructionSection(
                number: '5',
                title: 'Fetch Health Data',
                content: [
                  'After completing these steps, the user can fetch health data through the app.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionSection({
    required String number,
    required String title,
    required List<String> content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  number,
                  style: GoogleFonts.vazirmatn(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.vazirmatn(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        ...content.map(
              (item) => Padding(
            padding: EdgeInsets.only(left: 34.w, bottom: 8.h),
            child: Text(
              '• $item',
              style: GoogleFonts.vazirmatn(
                fontSize: 14.sp,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
      ],
    );
  }
}