import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/utils/app_colors/appColors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

class CompleteSetup extends StatefulWidget {
  const CompleteSetup({super.key});

  @override
  State<CompleteSetup> createState() => _CompleteSetupState();
}

class _CompleteSetupState extends State<CompleteSetup> {
  String percent = "70.0%";
  double percentage = 0.70;
  bool isButtonActive = false;
  bool isLoading = false;
  // late String name = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Replace with your image asset path
          fit: BoxFit.cover, // You can adjust the fit property as needed
        )),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0,right: 30),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Text(
                "We create your training plan",
                textAlign: TextAlign.center,
                style: GoogleFonts.barlow(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color:AppColors.white
                ),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 20.0,
                animation: true,
                animateFromLastPercent: true,
                // percent: percentage,
                percent: percentage,
                center: Text(
                  percent,
                  style: GoogleFonts.barlow(fontWeight: FontWeight.bold, fontSize: 20.0,color: AppColors.white),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppColors.contentColorPurple,
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Text(
                (percentage == 1) ? "Completed" : "Please Wait",
                textAlign: TextAlign.center,
                style: GoogleFonts.barlow(
                  fontSize: 13.sp,
                  color:AppColors.white
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              AppButton(text: "Start Training", onPressed: () {

              },),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     height: 7.5.h,
              //     width: 90.0.w,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     child: ElevatedButton(
              //       onPressed:
              //       // !isButtonActive
              //       //     ? null
              //       //     :
              //           () {
              //               // getUser(widget.token);
              //             },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: AppColors.white,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //       child: Text(
              //         "Start Training",
              //         style: GoogleFonts.poppins(fontSize: 15.sp),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
