import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/main_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';
import 'package:gymmerator/utils/nav/nav.dart';
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
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'assets/images/background.png'), // Replace with your image asset path
          fit: BoxFit.cover, // You can adjust the fit property as needed
        )),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                    color: AppColors.white),
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
              CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 12.0,
                animation: true,
                animateFromLastPercent: true,
                // percent: percentage,
                percent: percentage,
                center: Text(
                  percent,
                  style: GoogleFonts.barlow(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppColors.white),
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
                style:
                    GoogleFonts.barlow(fontSize: 13.sp, color: AppColors.white),
              ),
              const Spacer(),
              AppButton(
                text: "Start Training",
                onPressed: () {
                  Nav.push(context, const MainScreen());
                },
              ),
              const SizedBox(height: 10),
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
            ],
          ),
        ),
      ),
    ));
  }
}
