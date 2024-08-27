import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/exercise_details_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../utils/nav/nav.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Nav.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(width: screenWidth * 0.2),
                    Text("Exercise",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text("Warn-up (6)",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Nav.push(context, const ExerciseDetailsScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight * 0.12,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/pilates.png",
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Interval pilates",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp,
                                          color: Colors.black)),
                                  Text("00:30",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 11.sp, color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/lunge.png",
                              fit: BoxFit.cover),
                          SizedBox(width: screenWidth * 0.02),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Backward Lunge",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp, color: Colors.black)),
                                Text("00:30",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/pilates.png",
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Interval pilates",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp, color: Colors.black)),
                                Text("00:30",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/lunge.png",
                              fit: BoxFit.cover),
                          SizedBox(width: screenWidth * 0.02),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Backward Lunge",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp, color: Colors.black)),
                                Text("00:30",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/pilates.png",
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Interval pilates",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp, color: Colors.black)),
                                Text("00:30",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/lunge.png",
                              fit: BoxFit.cover),
                          SizedBox(width: screenWidth * 0.02),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Backward Lunge",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp, color: Colors.black)),
                                Text("00:30",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
