import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/user_issue_screen/user_issue_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/nav/nav.dart';
import '../../main_screen/profile_screen/profile_edit_screen/profile_edit_screen.dart';
import '../choose_plan_screen/choose_plan_screen.dart';

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
  double heightFeet = 0;
  double heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;
  String? dietPlan;

  bool checkboxValue = true;
  int selectedIndex = 0;

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
          image: AssetImage(
              'assets/images/background.png'), // Replace with your image asset path
          fit: BoxFit.cover, // You can adjust the fit property as needed
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
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
                              border: Border.all(color: Colors.white),
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
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 70,
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      contentPadding: const EdgeInsets.all(0),
                                      suffixText: weightUnit == WeightUnits.kg
                                          ? 'Kg'
                                          : 'Lb',
                                      suffixStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
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
                          ),
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
                                      heightUnit = index == 0
                                          ? HeightUnits.cm
                                          : HeightUnits.ftIn;
                                    });
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: heightUnit == HeightUnits.cm
                                      ? [
                                          buildTextField(heightCmController,
                                              (value) {
                                            if (value.isEmpty) {
                                              return;
                                            }
                                            setState(() {
                                              heightCm = double.parse(value);
                                            });
                                          }, 'Cm')
                                        ]
                                      : [
                                          buildTextField(heightFeetController,
                                              (value) {
                                            if (value.isEmpty) {
                                              return;
                                            }
                                            setState(() {
                                              heightFeet = double.parse(value);
                                            });
                                          }, 'Ft'),
                                          buildTextField(heightInchesController,
                                              (value) {
                                            if (value.isEmpty) {
                                              return;
                                            }
                                            setState(() {
                                              heightInches =
                                                  double.parse(value);
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
                    decoration: InputDecoration(
                      hintText: 'Enter your age',
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
                                title: Text('Select Goal',
                                    style: GoogleFonts.vazirmatn()),
                                content: SizedBox(
                                  width: screenWidth,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Lose Weight',
                                            style: GoogleFonts.vazirmatn()),
                                        value: 'Lose Weight',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Keep Fit',
                                            style: GoogleFonts.vazirmatn()),
                                        value: 'Keep Fit',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Get Stronger',
                                            style: GoogleFonts.vazirmatn()),
                                        value: 'Get Stronger',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile<String>(
                                        activeColor: const Color(0xff3F710D),
                                        title: Text('Gain Muscle Mass',
                                            style: GoogleFonts.vazirmatn()),
                                        value: 'Gain Muscle Mass',
                                        groupValue: tempSelectedGoal,
                                        onChanged: (String? value) {
                                          setState(() {
                                            tempSelectedGoal = value!;
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
                                      'CANCEL',
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
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
                    decoration: InputDecoration(
                      hintText: 'Enter your sleep hours 1 to 24',
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
                    decoration: InputDecoration(
                      hintText: 'Enter your meal frequency 1 to 5',
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
                    decoration: InputDecoration(
                      hintText: '5 Liters',
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
                    decoration: InputDecoration(
                      hintText: 'please enter your target weight',
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
                                title: Text('Select Diet Plan',
                                    style:
                                        GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                content: SizedBox(
                                  width: screenWidth,
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
                                      'CANCEL',
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
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
                    text: "Save",
                    onPressed: () async {
                      if (selectedIndex == 0) {
                        showSnackBar(context, "Please select gender");
                      } else if (weightKg == 0.0 && weightLb == 0.0) {
                        showSnackBar(context, "Please enter Weight");
                      } else if (heightCm == 0.0 && heightFeet == 0.0) {
                        showSnackBar(context, "Please enter height");
                      } else if (ageController.text.isEmpty) {
                        showSnackBar(context, "Please enter age");
                      } else if (goal == null) {
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
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.cm &&
                            selectedIndex == 1) {
                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: "Male",
                                heightUnit: "cm",
                                heightValue: heightCm,
                                weightUnit: "Kg",
                                weightValue: weightKg,
                                age: ageController.text,
                                goal: goal!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietPlan!,
                              ));
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.cm &&
                            selectedIndex == 2) {
                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: "Female",
                                heightUnit: "cm",
                                heightValue: heightCm,
                                weightUnit: "lb",
                                weightValue: weightLb,
                                age: ageController.text,
                                goal: goal!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietPlan!,
                              ));
                        }
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.ftIn &&
                            selectedIndex == 1) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: "Male",
                                heightUnit: "Ft-in",
                                heightValue: double.parse(val),
                                weightUnit: "Kg",
                                weightValue: weightKg,
                                age: ageController.text,
                                goal: goal!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietPlan!,
                              ));
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.ftIn &&
                            selectedIndex == 2) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          Nav.push(
                              context,
                              UserIssueScreen(
                                gender: "Female",
                                heightUnit: "Ft-in",
                                heightValue: double.parse(val),
                                weightUnit: "lb",
                                weightValue: weightLb,
                                age: ageController.text,
                                goal: goal!,
                                sleepHours: sleepingHoursController.text,
                                mealFrequency: mealFrequentlyController.text,
                                hydrationDaily: hydrationController.text,
                                targetWeight: targetWeightController.text,
                                dietPlan: dietPlan!,
                              ));
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildTextField(TextEditingController controller,
      Function(String)? onChanged, String suffixText) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        style: GoogleFonts.vazirmatn(
          fontSize: 14,
        ),
        keyboardType: TextInputType.number,
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
          suffixStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
