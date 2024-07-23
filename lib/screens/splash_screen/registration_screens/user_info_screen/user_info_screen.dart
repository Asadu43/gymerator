import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/nav/nav.dart';
import '../../main_screen/profile_screen/profile_edit_screen/profile_edit_screen.dart';
import '../choose_plan_screen/choose_plan_screen.dart';
import '../user_issue_screen/user_issue_screen.dart';



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
  WeightUnits weightUnit = WeightUnits.kg;
  HeightUnits heightUnit = HeightUnits.cm;
  double weightLb = 0;
  double weightKg = 0;
  double heightFeet = 0;
  double heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;

  bool checkboxValue = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05,),
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
                          Text("Weight",style: GoogleFonts.vazirmatn(color: Colors.white,fontSize: 14.sp),),
                          SizedBox(height: screenHeight * 0.02,),
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
                                      weightUnit =
                                      index == 0 ? WeightUnits.kg : WeightUnits.lb;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 70,
                                  child: TextField(
                                    cursorColor: Colors.black,
          
                                    style: const TextStyle(
                                        fontSize: 16,),
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
                                      suffixText:
                                      weightUnit == WeightUnits.kg ? 'Kg' : 'Lb',
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
                          Text("Height",style: GoogleFonts.vazirmatn(color: Colors.white,fontSize: 14.sp),),
                          SizedBox(height: screenHeight * 0.02,),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: heightUnit == HeightUnits.cm
                                      ? [
                                    buildTextField(heightCmController, (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      setState(() {
                                        heightCm = double.parse(value);
                                      });
                                    }, 'Cm')
                                  ]
                                      : [
                                    buildTextField(heightFeetController, (value) {
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
                                            heightInches = double.parse(value);
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
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: ageController,
                    style: GoogleFonts.vazirmatn(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your age',

                      hintStyle: GoogleFonts.vazirmatn(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButton<String>(
                      underline: Container(),
                      isExpanded: true,
                      hint:  Text('Select your goal',style: GoogleFonts.vazirmatn(color: Colors.white),),
                      value: goal,
                      style: const TextStyle(color: Colors.white),
                      items: <String>['Lose Weight', 'Keep Fit','Get Stronger', 'Gain Muscle Mass']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: GoogleFonts.vazirmatn(color: Colors.black),),
                        );
                      }).toList(),
                      onChanged: (newGoal) {
                        setState(() {
                          goal = newGoal!;
                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  AppButton(
                    text: "Save",
                    onPressed: () async {

                      if(ageController.text.isEmpty || goal == null){
                        showSnackBar(context, "Some thing is missing");
                      }else{
                        if(weightUnit == WeightUnits.kg && heightUnit == HeightUnits.cm && selectedIndex == 1){
                          print("weightKg... $weightKg");
                          print("heightCm... $heightCm");
                          Nav.push(context, ChoosePlanScreen(gender: "Male",heightUnit: "cm",heightValue: heightCm,weightUnit: "Kg",weightValue: weightKg,age: ageController.text,goal: goal!));

                        }if(weightUnit == WeightUnits.lb && heightUnit == HeightUnits.cm && selectedIndex == 2){
                          print("weightLB... $weightLb");
                          print("heightCm... $heightCm");
                          Nav.push(context, ChoosePlanScreen(gender: "Female",heightUnit: "cm",heightValue: heightCm,weightUnit: "lb",weightValue: weightLb,age: ageController.text,goal: goal!));

                        }if(weightUnit == WeightUnits.kg && heightUnit == HeightUnits.ftIn && selectedIndex == 1){
                          print("weightKg... $weightKg");
                          print("heightFeet... $heightFeet");
                          print("heightInches... $heightInches");

                          String val = "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          Nav.push(context, ChoosePlanScreen(gender: "Male",heightUnit: "Ft-in",heightValue: double.parse(val),weightUnit: "Kg",weightValue: weightKg,age: ageController.text,goal: goal!));

                        }if(weightUnit == WeightUnits.lb && heightUnit == HeightUnits.ftIn  && selectedIndex == 2){
                          print("weightKg... $weightLb");
                          print("heightFeet... $heightFeet");
                          print("heightInches... $heightInches");
                          print("${(heightFeet.toInt())}.${heightInches.toInt()}");

                          String val = "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          Nav.push(context, ChoosePlanScreen(gender: "Female",heightUnit: "Ft-in",heightValue: double.parse(val),weightUnit: "lb",weightValue: weightLb,age: ageController.text,goal: goal!));


                        }
                      }
                      // await _savePressButtonPressed(context);
                      // print("selectedIndex..... $selectedIndex");
                      // print("weightUnit..... $weightUnit");
                      // print("heightUnit..... $heightUnit");
                      // print("age..... $ageController");
                      // print("goal..... $goal");
                      //
                      // print("weightKgController...,$weightLb");
                      // print("heightCmController...,$heightCm");
                      // print("heightFeetController...,$heightFeet");
                      // print("heightInchesController...,$heightInches");

                      // Nav.push(context, const UserIssueScreen());
          
                    },
                  ),
                  const SizedBox(height: 20,)
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
        style: const TextStyle(fontSize: 14,),
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
