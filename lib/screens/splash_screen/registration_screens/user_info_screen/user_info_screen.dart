import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/user_issue_screen/user_issue_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/nav/nav.dart';
import '../../main_screen/profile_screen/profile_edit_screen/profile_edit_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController weightLbController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sleepingHoursController = TextEditingController();
  final TextEditingController mealFrequentlyController =
      TextEditingController();
  final TextEditingController hydrationController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();
  WeightUnits weightUnit = WeightUnits.kg;
  HeightUnits heightUnit = HeightUnits.cm;
  double weightLb = 0;
  double weightKg = 0;
  int heightFeet = 0;
  int heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;
  int? goalType;
  String? dietPlan;
  int? dietType;

  bool checkboxValue = true;
  int selectedIndex = 0;

  void _validateInput(TextEditingController controller, String value) {
    if (value.isNotEmpty) {
      int number = int.parse(value);
      if (number < 1) {
        controller.text = '1';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      } else if (number > 24) {
        controller.text = '24';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  void _validateMeal(TextEditingController controller, String value) {
    if (value.isNotEmpty) {
      int number = int.parse(value);
      if (number < 1) {
        controller.text = '1';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      } else if (number > 5) {
        controller.text = '5';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  void _validateHydration(TextEditingController controller, String value) {
    if (value.isNotEmpty) {
      int number = int.parse(value);
      if (number < 1) {
        controller.text = '1';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      } else if (number > 10) {
        controller.text = '10';
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          // Replace with your image asset path
          fit: BoxFit.cover, // You can adjust the fit property as needed
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Male",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.white, fontSize: 14.sp),
                          ),
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
                              borderRadius: BorderRadius.circular(20),
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
                              child: Image.asset("assets/icons/male.png"),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Female",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.white, fontSize: 14.sp),
                          ),
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
                              borderRadius: BorderRadius.circular(20),
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
                              child: Image.asset("assets/icons/female.png"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Weight",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.white, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.80),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ToggleSwitch(
                                  initialLabelIndex:
                                  weightUnit == WeightUnits.kg ? 0 : 1,
                                  totalSwitches: 2,
                                  activeBgColor: const [
                                    Color(0xffB14501),
                                    Color(0xff3F710D)
                                  ],
                                  labels: const ['Kg', 'Lb'],
                                  onToggle: (index) {
                                    setState(() {
                                      weightUnit = index == 0
                                          ? WeightUnits.kg
                                          : WeightUnits.lb;
                                      if (weightUnit == WeightUnits.kg) {
                                        weightLbController.clear();
                                        weightLb = 0.0;

                                      } else {
                                        weightKgController.clear();
                                        weightKg = 0.0;
                                      }
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: screenWidth * 0.170,
                                  child: TextField(
                                    controller: weightUnit == WeightUnits.kg
                                        ? weightKgController
                                        : weightLbController,
                                    cursorColor: Colors.black,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Only allow digits
                                      LengthLimitingTextInputFormatter(
                                          3), // Limit to 3 characters
                                    ],
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black)),
                                      enabledBorder:
                                      const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black)),
                                      focusedBorder:
                                      const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black)),
                                      contentPadding:
                                      const EdgeInsets.all(0),
                                      suffixText:
                                      weightUnit == WeightUnits.kg
                                          ? 'Kg'
                                          : 'Lb',
                                      suffixStyle: GoogleFonts.vazirmatn(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) return;

                                      setState(() {
                                        if (weightUnit == WeightUnits.kg) {
                                          weightKg = double.parse(value);
                                        } else {
                                          weightLb = double.parse(value);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Height",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.white, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: screenWidth * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white70.withOpacity(0.80),
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ToggleSwitch(
                                  initialLabelIndex:
                                  heightUnit == HeightUnits.cm ? 0 : 1,
                                  totalSwitches: 2,
                                  activeBgColor: const [
                                    Color(0xffB14501),
                                    Color(0xff3F710D)
                                  ],
                                  labels: const ['Cm', 'Ft-In'],
                                  onToggle: (index) {
                                    setState(() {
                                      heightUnit = index == 0 ? HeightUnits.cm : HeightUnits.ftIn;

                                      if (heightUnit == HeightUnits.cm) {
                                        // Clear only feet and inches controllers if 'Cm' is selected
                                        heightFeetController.clear();
                                        heightInchesController.clear();
                                        heightFeet = 0;
                                        heightInches = 0;

                                      } else {
                                        // Clear only cm controller if 'Ft-In' is selected
                                        heightCmController.clear();
                                        heightCm = 0.0;
                                      }
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: heightUnit == HeightUnits.cm
                                      ? [
                                    buildTextField(
                                        heightCmController, 1,
                                            (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            heightCm =
                                                double.parse(value);
                                          });
                                        }, 'Cm')
                                  ]
                                      : [
                                    buildTextField(
                                        heightFeetController, 2,
                                            (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            heightFeet = int.parse(value);
                                          });
                                        }, 'Ft'),
                                    buildTextField(
                                        heightInchesController, 2,
                                            (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          setState(() {
                                            heightInches =
                                                int.parse(value);
                                          });
                                        }, 'In'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Age',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFormField(
                    controller: ageController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Only allow digits
                      LengthLimitingTextInputFormatter(
                          2), // Limit to 3 characters
                    ],
                    decoration: InputDecoration(
                      hintText: 'Your age',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Goal',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String? tempSelectedGoal = goal;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: Text('Select Goal',
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold)),
                                content: SizedBox(
                                  width: screenWidth * 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Lose Weight',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Lose Weight',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 0;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Keep Fit',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Keep Fit',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 1;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Improve Endurance',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Improve Endurance',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 2;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Increase Strength',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Increase Strength',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 3;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Enhance Flexibility',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Enhance Flexibility',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 4;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Muscle Gain',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Muscle Gain',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 5;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Improve Cardio Health',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Improve Cardio Health',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            goalType = 6;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                contentTextStyle:
                                    GoogleFonts.vazirmatn(color: Colors.black),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp, color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Ok',
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp, color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        goal = tempSelectedGoal;
                                      });
                                      // Call the main setState to update the UI after dialog is closed
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ).then(
                        (value) {
                          setState(() {
                            goal;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          goal == null
                              ? Text(
                                  "Select your goal",
                                  style:
                                      GoogleFonts.vazirmatn(color: Colors.grey),
                                )
                              : Text(
                                  "$goal",
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white),
                                ),
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Sleep Hours',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFormField(
                    controller: sleepingHoursController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Only allow digits
                      LengthLimitingTextInputFormatter(
                          2), // Limit to 3 characters
                    ],
                    onChanged: (value) {
                      _validateInput(sleepingHoursController, value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Sleep hours 1 to 24',
                      hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Meal Frequency',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFormField(
                    controller: mealFrequentlyController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      _validateMeal(mealFrequentlyController, value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Meal frequency 1 to 5',
                      hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Hydration Per Day',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFormField(
                    controller: hydrationController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      _validateHydration(hydrationController, value);
                    },
                    decoration: InputDecoration(
                      hintText: '5 Liters',
                      hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Target Weight',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextFormField(
                    controller: targetWeightController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Only allow digits
                      LengthLimitingTextInputFormatter(
                          3), // Limit to 3 characters
                    ],
                    decoration: InputDecoration(
                      hintText: 'Target weight',
                      hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Diet Plan',
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String? tempSelectedGoal = dietPlan;

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                title: Text('Select Diet Plan',
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold)),
                                content: SizedBox(
                                  width: screenWidth * 1,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Balanced Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Balanced Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 0;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Low-Carb/Keto Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Low-Carb/Keto Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 1;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('High-Protein Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'High-Protein Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 2;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Vegan/Vegetarian Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Vegan/Vegetarian Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 3;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Mediterranean Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Mediterranean Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 4;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Intermittent Fasting',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Intermittent Fasting',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 5;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Paleo Diet',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 10.sp)),
                                        value: 'Paleo Diet',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                            dietType = 6;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                contentTextStyle:
                                    GoogleFonts.vazirmatn(color: Colors.black),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp, color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Ok',
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp, color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        dietPlan = tempSelectedGoal;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ).then(
                        (value) {
                          setState(() {
                            dietPlan;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          dietPlan == null
                              ? Text(
                                  "Select Diet Plan",
                                  style:
                                      GoogleFonts.vazirmatn(color: Colors.grey),
                                )
                              : Text(
                                  "$dietPlan",
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white),
                                ),
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.04,
                  ),
                  AppButton(
                    text: "Next",
                    onPressed: () async {
                      if (selectedIndex == 0) {
                        showSnackBar(context, "Please select gender");
                      } else if (weightKg == 0.0 && weightLb == 0.0) {
                        showSnackBar(context, "Please enter Weight");
                      } else if (heightCm == 0.0 && heightFeet == 0.0) {
                        showSnackBar(context, "Please enter height");
                      } else if (ageController.text.isEmpty) {
                        showSnackBar(context, "Please enter age");
                      } else if (goalType == null) {
                        showSnackBar(context, "Please select goal");
                      } else if (sleepingHoursController.text.isEmpty) {
                        showSnackBar(context, "Please enter sleep hour");
                      } else if (mealFrequentlyController.text.isEmpty) {
                        showSnackBar(context, "Please enter meal frequently");
                      } else if (hydrationController.text.isEmpty) {
                        showSnackBar(context, "Please enter daily hydration");
                      } else if (targetWeightController.text.isEmpty) {
                        showSnackBar(context, "Please enter target weight");
                      } else if (dietPlan == null) {
                        showSnackBar(context, "Please select diet plan");
                      } else {
                        print(selectedIndex);
                        print(heightUnit);
                        print(weightKg);
                        print(heightCm);
                        print(weightLb);
                        print(ageController.text);
                        print(goal);
                        print(sleepingHoursController.text);
                        print(hydrationController.text);
                        print(targetWeightController.text);
                        print(dietType);
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.cm) {
                          print("Press 1");
                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: "Male",
                                heightUnit: "cm",
                                heightValue: heightCm,
                                weightUnit: "Kg",
                                weightValue: weightKg,
                                age: ageController.text,
                                goal: goalType!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietType!,
                              ));
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.cm) {
                          print("Press 2");

                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: selectedIndex == 2 ? "Female" : "Male",
                                heightUnit: "cm",
                                heightValue: heightCm,
                                weightUnit: "lb",
                                weightValue: weightLb,
                                age: ageController.text,
                                goal: goalType!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietType!,
                              ));
                        }
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.ftIn) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";
                          print("Press 3");

                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: selectedIndex == 2 ? "Female" : "Male",
                                heightUnit: "Ft-in",
                                heightValue: double.parse(val),
                                weightUnit: "Kg",
                                weightValue: weightKg,
                                age: ageController.text,
                                goal: goalType!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietType!,
                              ));
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.ftIn) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";
                          print("Press 4");

                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: selectedIndex == 2 ? "Female" : "Male",
                                heightUnit: "Ft-in",
                                heightValue: double.parse(val),
                                weightUnit: "lb",
                                weightValue: weightLb,
                                age: ageController.text,
                                goal: goalType!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietType!,
                              ));
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildTextField(TextEditingController controller, int num,
      Function(String)? onChanged, String suffixText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.160,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        style: GoogleFonts.vazirmatn(
          fontSize: 14.sp,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: num == 1
            ? [
                FilteringTextInputFormatter.digitsOnly, // Only allow digits
                LengthLimitingTextInputFormatter(3), // Limit to 3 characters
              ]
            : [
                FilteringTextInputFormatter.digitsOnly, // Only allow digits
                LengthLimitingTextInputFormatter(2), // Limit to 2 characters
              ],
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.all(0),
          suffixText: suffixText,
          suffixStyle: GoogleFonts.vazirmatn(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
