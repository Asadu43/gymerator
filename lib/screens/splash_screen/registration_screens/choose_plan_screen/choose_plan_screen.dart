import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../complete_setup/complete_setup.dart';

class ChoosePlanScreen extends StatefulWidget {
  final String gender;
  final String heightUnit;
  final double heightValue;
  final String weightUnit;
  final double weightValue;
  final String age;
  final String goal;
  final String sleepHours;
  final String mealFrequency;
  final String hydrationDaily;
  final String targetWeight;
  final String dietPlan;
  final String selectMedicalName;
  final String medicalCondition;

  const ChoosePlanScreen(
      {super.key,
      required this.gender,
      required this.heightUnit,
      required this.heightValue,
      required this.weightUnit,
      required this.weightValue,
      required this.age,
      required this.goal,
      required this.sleepHours,
      required this.mealFrequency,
      required this.hydrationDaily,
      required this.targetWeight,
      required this.dietPlan, required this.selectMedicalName, required this.medicalCondition});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Replace with your image asset path
            fit: BoxFit.cover, // You can adjust the fit property as needed
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight / 14,
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Text("Choose Your Plan",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                Text(
                    "Your coach will design a weight loss plan for you to suit you best",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vazirmatn(
                        fontSize: 11.sp, color: Colors.grey)),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.18,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                            gradient:
                                (checkboxValue == true && selectedIndex == 1)
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Color(0xffB14501),
                                          Color(0xff3F710D),
                                        ],
                                      )
                                    : const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if ((checkboxValue == true) &&
                                    (selectedIndex == 1)) {
                                  setState(() {
                                    checkboxValue = false;
                                    selectedIndex = 0;
                                  });
                                } else {
                                  setState(() {
                                    checkboxValue = true;
                                    selectedIndex = 1;
                                  });
                                }
                              });
                            },
                            child: Image.asset("assets/images/begginer.png"),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.030,
                        ),
                        Text("Beginner",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text("5-10 mins a day",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 8.sp, color: Colors.grey)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.18,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                            gradient:
                                (checkboxValue == true && selectedIndex == 2)
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Color(0xffB14501),
                                          Color(0xff3F710D),
                                        ],
                                      )
                                    : const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if ((checkboxValue == true) &&
                                    (selectedIndex == 2)) {
                                  setState(() {
                                    checkboxValue = false;
                                    selectedIndex = 0;
                                  });
                                } else {
                                  setState(() {
                                    checkboxValue = true;
                                    selectedIndex = 2;
                                  });
                                }
                              });
                            },
                            child: Image.asset("assets/images/intermedate.png"),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.030,
                        ),
                        Text("Intermediate",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text("10-20 mins a day",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 8.sp, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.18,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                            gradient:
                                (checkboxValue == true && selectedIndex == 3)
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Color(0xffB14501),
                                          Color(0xff3F710D),
                                        ],
                                      )
                                    : const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if ((checkboxValue == true) &&
                                    (selectedIndex == 3)) {
                                  setState(() {
                                    checkboxValue = false;
                                    selectedIndex = 0;
                                  });
                                } else {
                                  setState(() {
                                    checkboxValue = true;
                                    selectedIndex = 3;
                                  });
                                }
                              });
                            },
                            child: Image.asset("assets/images/advance.png"),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.030,
                        ),
                        Text("Advance",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text("15-30 mins a day",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 8.sp, color: Colors.grey)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight * 0.18,
                          width: screenWidth * 0.4,
                          decoration: BoxDecoration(
                            // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                            gradient:
                                (checkboxValue == true && selectedIndex == 4)
                                    ? const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Color(0xffB14501),
                                          Color(0xff3F710D),
                                        ],
                                      )
                                    : const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // stops: const [0.0, 1.0],
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                      ),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if ((checkboxValue == true) &&
                                    (selectedIndex == 4)) {
                                  setState(() {
                                    checkboxValue = false;
                                    selectedIndex = 0;
                                  });
                                } else {
                                  setState(() {
                                    checkboxValue = true;
                                    selectedIndex = 4;
                                  });
                                }
                              });
                            },
                            child: Image.asset("assets/images/expert.png"),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.030,
                        ),
                        Text("Expert",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text("20-35 mins a day",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 8.sp, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: "Next",
                  onPressed: () async {
                    if (selectedIndex == 0) {
                      showSnackBar(context, "Please select plan");
                    } else {
                      if (widget.goal == "Lose Weight") {
                        Nav.push(
                            context,
                            CompleteSetup(
                              gender: "Male",
                              heightUnit: "cm",
                              heightValue: widget.heightValue,
                              weightUnit: "Kg",
                              weightValue: widget.weightValue,
                              age: int.parse(widget.age),
                              goal: 0,
                              plan: selectedIndex,
                            ));
                      } else if (widget.goal == "Keep Fit") {
                        Nav.push(
                            context,
                            CompleteSetup(
                              gender: "Male",
                              heightUnit: "cm",
                              heightValue: widget.heightValue,
                              weightUnit: "Kg",
                              weightValue: widget.weightValue,
                              age: int.parse(widget.age),
                              goal: 1,
                              plan: selectedIndex,
                            ));
                      } else if (widget.goal == "Get Stronger") {
                        Nav.push(
                            context,
                            CompleteSetup(
                              gender: "Male",
                              heightUnit: "cm",
                              heightValue: widget.heightValue,
                              weightUnit: "Kg",
                              weightValue: widget.weightValue,
                              age: int.parse(widget.age),
                              goal: 2,
                              plan: selectedIndex,
                            ));
                      } else if (widget.goal == "Gain Muscle Mass") {
                        Nav.push(
                            context,
                            CompleteSetup(
                              gender: "Male",
                              heightUnit: "cm",
                              heightValue: widget.heightValue,
                              weightUnit: "Kg",
                              weightValue: widget.weightValue,
                              age: int.parse(widget.age),
                              goal: 3,
                              plan: selectedIndex,
                            ));
                      }
                    }
                  },
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
