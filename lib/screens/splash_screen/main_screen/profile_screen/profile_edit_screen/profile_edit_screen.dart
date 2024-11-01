import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart'
    hide LoadingState;
import '../../../../../ui_component/show_snackbar.dart';
import '../../../../../utils/nav/nav.dart';

enum WeightUnits { kg, lb }

enum HeightUnits { cm, ftIn }

class ProfileEditScreen extends StatefulWidget {
  final String goal;
  final int age;
  final String weight;
  final String height;
  final double weightValue;
  final double heightValue;

  const ProfileEditScreen(
      {super.key,
      required this.age,
      required this.goal,
      required this.weight,
      required this.height,
      required this.weightValue,
      required this.heightValue});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  TextEditingController weightLbController = TextEditingController();
  TextEditingController heightCmController = TextEditingController();
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  WeightUnits weightUnit = WeightUnits.kg;
  HeightUnits heightUnit = HeightUnits.cm;
  double? weightLb;
  double? weightKg;
  int heightFeet = 0;
  int heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;

  @override
  void initState() {
    goal = widget.goal;
    ageController = TextEditingController(text: widget.age.toString());
    if (widget.weight == "Kg") {
      weightUnit = WeightUnits.kg;
      weightKg = widget.weightValue;
      weightKgController =
          TextEditingController(text: widget.weightValue.toString());
    } else {
      weightUnit = WeightUnits.lb;
      weightLb = widget.weightValue;
      weightLbController =
          TextEditingController(text: widget.weightValue.toString());
    }

    if (widget.height == "Ft-in") {
      String value = widget.heightValue.toString();

      List<String> versionParts = value.split('.');
      int majorVersion = int.parse(versionParts[0]);
      int minorVersion = int.parse(versionParts[1]);
      heightUnit = HeightUnits.ftIn;
      heightFeet = majorVersion;
      heightInches = minorVersion;

      heightFeetController =
          TextEditingController(text: majorVersion.toString());
      heightInchesController =
          TextEditingController(text: minorVersion.toString());
    } else {
      heightUnit = HeightUnits.cm;
      heightCmController =
          TextEditingController(text: widget.heightValue.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("-------> $goal");
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => UpdateUserInfoCubit(),
      child: BlocConsumer<UpdateUserInfoCubit, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is FailedToUpdateUserInfo) {
            showSnackBar(context, state.message);
          }
          if (state is UpdateUserSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            context.read<AllFavoriteProductsCubit>().featuredRequest();
            Nav.pop(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Profile Edit'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weight",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 14.sp),
                            ),
                            Container(
                              width: screenWidth * 0.4,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
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
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: TextField(
                                      controller: weightUnit == WeightUnits.kg
                                          ? weightKgController
                                          : weightLbController,
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
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
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
                            Text("Height",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black, fontSize: 14.sp)),
                            Container(
                              width: screenWidth * 0.4,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  shape: BoxShape.rectangle),
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
                                                heightFeet = int.parse(value);
                                              });
                                            }, 'Ft'),
                                            buildTextField(
                                                heightInchesController,
                                                (value) {
                                              if (value.isEmpty) {
                                                return;
                                              }
                                              setState(() {
                                                heightInches = int.parse(value);
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        hint: const Text('Select your goal'),
                        value: goal,
                        items: <String>[
                          'Lose Weight',
                          'Keep Fit',
                          'improve endurance',
                          'increase strength',
                          'Enhance Flexibility',
                          'Muscle Gain',
                          'Improve Cardio Health'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
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
                      onPressed: () {
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.cm &&
                            heightCm != 0.0 &&
                            weightKg != 0.0) {
                          context
                              .read<UpdateUserInfoCubit>()
                              .editProfileRequest(
                                  heightUnit: "cm",
                                  heightValue: heightCm,
                                  weightUnit: "Kg",
                                  weightValue: weightKg!,
                                  age: int.parse(ageController.text),
                                  goal: goal!);
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.cm &&
                            heightCm != 0.0 &&
                            weightLb != 0.0) {
                          context
                              .read<UpdateUserInfoCubit>()
                              .editProfileRequest(
                                  heightUnit: "cm",
                                  heightValue: heightCm,
                                  weightUnit: "lb",
                                  weightValue: weightLb!,
                                  age: int.parse(ageController.text),
                                  goal: goal!);
                        }
                        if (weightUnit == WeightUnits.kg &&
                            heightUnit == HeightUnits.ftIn &&
                            heightFeet != 0.0 &&
                            weightKg != 0.0) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          context
                              .read<UpdateUserInfoCubit>()
                              .editProfileRequest(
                                  heightUnit: "Ft-in",
                                  heightValue: double.parse(val),
                                  weightUnit: "Kg",
                                  weightValue: weightKg!,
                                  age: int.parse(ageController.text),
                                  goal: goal!);
                        }
                        if (weightUnit == WeightUnits.lb &&
                            heightUnit == HeightUnits.ftIn &&
                            heightFeet != 0.0 &&
                            weightLb != 0.0) {
                          String val =
                              "${(heightFeet.toInt())}.${heightInches.toInt()}";

                          context
                              .read<UpdateUserInfoCubit>()
                              .editProfileRequest(
                                  heightUnit: "Ft-in",
                                  heightValue: double.parse(val),
                                  weightUnit: "lb",
                                  weightValue: weightLb!,
                                  age: int.parse(ageController.text),
                                  goal: goal!);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
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
        style: const TextStyle(
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
