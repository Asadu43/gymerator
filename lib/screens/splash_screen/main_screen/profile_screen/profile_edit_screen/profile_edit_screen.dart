import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

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
  final int sleepingHours;
  final int mealFrequency;
  final int waterHydration;
  final double targetWeight;
  final String dietPlan;

  const ProfileEditScreen(
      {super.key,
      required this.age,
      required this.goal,
      required this.weight,
      required this.height,
      required this.weightValue,
      required this.heightValue,
      required this.sleepingHours,
      required this.mealFrequency,
      required this.waterHydration,
      required this.targetWeight,
      required this.dietPlan});

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

  TextEditingController sleepingHoursController = TextEditingController();
  TextEditingController mealFrequentlyController = TextEditingController();
  TextEditingController hydrationController = TextEditingController();
  TextEditingController targetWeightController = TextEditingController();

  WeightUnits weightUnit = WeightUnits.kg;
  HeightUnits heightUnit = HeightUnits.cm;
  double? weightLb;
  double? weightKg;
  int heightFeet = 0;
  int heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;

  String? dietPlan;
  int? dietType;

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

    sleepingHoursController =
        TextEditingController(text: widget.sleepingHours.toString());
    mealFrequentlyController =
        TextEditingController(text: widget.mealFrequency.toString());
    hydrationController =
        TextEditingController(text: widget.waterHydration.toString());
    targetWeightController =
        TextEditingController(text: widget.targetWeight.toString());
    dietPlan = widget.dietPlan.toString();
    if (dietPlan == "Balanced Diet") {
      dietType = 0;
    } else if (dietPlan == "Low-Carb/Keto Diet") {
      dietType = 1;
    } else if (dietPlan == "High-Protein Diet") {
      dietType = 2;
    } else if (dietPlan == "Vegan/Vegetarian Diet") {
      dietType = 3;
    } else if (dietPlan == "Mediterranean Diet") {
      dietType = 4;
    } else if (dietPlan == "Intermittent Fasting") {
      dietType = 5;
    } else if (dietPlan == "Paleo Diet") {
      dietType = 6;
    }
    super.initState();
  }

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
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Weight",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black, fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                  color: Colors.white70.withOpacity(0.80),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.r),
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
                                            weightLb = null;

                                          } else {
                                            weightKgController.clear();
                                            weightKg = null;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 0.17.sw,
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
                                              fontSize: 12.sp,
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
                          SizedBox(width: 20.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Height",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black, fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                padding:EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                  color: Colors.white70.withOpacity(0.80),
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.r),
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
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Enter your age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(30.r),
                            )
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Goal',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
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
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                    title: Text('Select Goal',
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold)),
                                    content: SizedBox(
                                      width: 1.sw,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Lose Weight',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Lose Weight',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Keep Fit',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Keep Fit',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Improve Endurance',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Improve Endurance',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Increase Strength',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Increase Strength',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Enhance Flexibility',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Enhance Flexibility',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Muscle Gain',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Muscle Gain',
                                            groupValue: tempSelectedGoal,
                                            onChanged: (String? value) {
                                              setState(() {
                                                tempSelectedGoal = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Improve Cardio Health',
                                                style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                            value: 'Improve Cardio Health',
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
                                    contentTextStyle: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 18.sp,
                                              color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Ok',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 18.sp,
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
                          height: 53.h,
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
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.grey),
                                    )
                                  : Text(
                                      toTitleCase(goal!),
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
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
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Sleep Hours',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: sleepingHoursController,
                        style: GoogleFonts.vazirmatn(color: Colors.black),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
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
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Meal frequency',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: mealFrequentlyController,
                        style: GoogleFonts.vazirmatn(color: Colors.black),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          _validateMeal(mealFrequentlyController, value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Meal frequency 1 to 5',
                          hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hydration Per Day',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: hydrationController,
                        style: GoogleFonts.vazirmatn(color: Colors.black),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        onChanged: (value) {
                          _validateHydration(hydrationController, value);
                        },
                        decoration: InputDecoration(
                          hintText: '5 Liters',
                          hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Target Weight',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        controller: targetWeightController,
                        style: GoogleFonts.vazirmatn(color: Colors.black),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
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
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Diet Plan',
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
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
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold)),
                                    content: SizedBox(
                                      width: 1.sw,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RadioListTile<String>(
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Balanced Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Low-Carb/Keto Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('High-Protein Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Vegan/Vegetarian Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Mediterranean Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Intermittent Fasting',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                            activeColor:
                                                const Color(0xff3F710D),
                                            title: Text('Paleo Diet',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp)),
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
                                    contentTextStyle: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 18.sp,
                                              color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          'Ok',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 18.sp,
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
                          height: 53.h,
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
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.grey),
                                    )
                                  : Text(
                                      "$dietPlan",
                                      style: GoogleFonts.vazirmatn(
                                          color: Colors.black),
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
                        height: 0.03.sh,
                      ),
                      AppButton(
                        text: "Update",
                        onPressed: () {
                          // submitProfileUpdate(context);


                          print(heightCm);
                          print(heightFeet);
                          if (weightKg == null && weightLb == null) {
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
                            showSnackBar(
                                context, "Please enter meal frequently");
                          } else if (hydrationController.text.isEmpty) {
                            showSnackBar(
                                context, "Please enter daily hydration");
                          } else if (targetWeightController.text.isEmpty) {
                            showSnackBar(context, "Please enter target weight");
                          } else if (dietPlan == null) {
                            showSnackBar(context, "Please select diet plan");
                          } else {
                            if (weightUnit == WeightUnits.kg &&
                                heightUnit == HeightUnits.cm) {

                              print("Hello 1");
                              context
                                  .read<UpdateUserInfoCubit>()
                                  .editProfileRequest(
                                    heightUnit: "cm",
                                    heightValue: heightCm,
                                    weightUnit: "Kg",
                                    weightValue: weightKg!,
                                    age: int.parse(ageController.text),
                                    goal: goal!,
                                    sleepingHours:
                                        int.parse(sleepingHoursController.text),
                                    mealFrequency: int.parse(
                                        mealFrequentlyController.text),
                                    waterHydration:
                                        int.parse(hydrationController.text),
                                    targetWeight: double.parse(
                                        targetWeightController.text),
                                    dietPlan: dietType!,
                                  );
                            }
                            if (weightUnit == WeightUnits.lb &&
                                heightUnit == HeightUnits.cm) {

                              print("Hello 2");
                              context
                                  .read<UpdateUserInfoCubit>()
                                  .editProfileRequest(
                                    heightUnit: "cm",
                                    heightValue: heightCm,
                                    weightUnit: "lb",
                                    weightValue: weightLb!,
                                    age: int.parse(ageController.text),
                                    goal: goal!,
                                    sleepingHours:
                                        int.parse(sleepingHoursController.text),
                                    mealFrequency: int.parse(
                                        mealFrequentlyController.text),
                                    waterHydration:
                                        int.parse(hydrationController.text),
                                    targetWeight: double.parse(
                                        targetWeightController.text),
                                    dietPlan: dietType!,
                                  );
                            }
                            if (weightUnit == WeightUnits.kg &&
                                heightUnit == HeightUnits.ftIn) {

                              print("Hello 3");
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
                                    goal: goal!,
                                    sleepingHours:
                                        int.parse(sleepingHoursController.text),
                                    mealFrequency: int.parse(
                                        mealFrequentlyController.text),
                                    waterHydration:
                                        int.parse(hydrationController.text),
                                    targetWeight: double.parse(
                                        targetWeightController.text),
                                    dietPlan: dietType!,
                                  );
                            }
                            if (weightUnit == WeightUnits.lb &&
                                heightUnit == HeightUnits.ftIn) {

                              print("Hello 4");
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
                                    goal: goal!,
                                    sleepingHours:
                                        int.parse(sleepingHoursController.text),
                                    mealFrequency: int.parse(
                                        mealFrequentlyController.text),
                                    waterHydration:
                                        int.parse(hydrationController.text),
                                    targetWeight: double.parse(
                                        targetWeightController.text),
                                    dietPlan: dietType!,
                                  );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox buildTextField(TextEditingController controller, int num,
      Function(String)? onChanged, String suffixText) {
    return SizedBox(
      width: 0.16.sw,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        textAlign: TextAlign.center,
        style: GoogleFonts.vazirmatn(
          fontSize: 12.sp,
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
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  String toTitleCase(String text) {
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void submitProfileUpdate(BuildContext context) {
    if (_validateInputs(context)) {
      final heightData = _getHeightData();
      final weightData = _getWeightData();

      context.read<UpdateUserInfoCubit>().editProfileRequest(
            heightUnit: heightData['unit'],
            heightValue: heightData['value'],
            weightUnit: weightData['unit'],
            weightValue: weightData['value'],
            age: int.parse(ageController.text),
            goal: goal!,
            sleepingHours: int.parse(sleepingHoursController.text),
            mealFrequency: int.parse(mealFrequentlyController.text),
            waterHydration: int.parse(hydrationController.text),
            targetWeight: double.parse(targetWeightController.text),
            dietPlan: dietType!,
          );
    }
  }

// Validate all input fields
  bool _validateInputs(BuildContext context) {
    final validations = {
      "Please enter Weight": weightKg != null || weightLb != null,
      "Please enter height": heightCm != 0.0 || heightFeet != 0.0,
      "Please enter age": ageController.text.isNotEmpty,
      "Please select goal": goal != null,
      "Please enter sleep hour": sleepingHoursController.text.isNotEmpty,
      "Please enter meal frequency": mealFrequentlyController.text.isNotEmpty,
      "Please enter daily hydration": hydrationController.text.isNotEmpty,
      "Please enter target weight": targetWeightController.text.isNotEmpty,
      "Please select diet plan": dietType != null,
    };

    for (var entry in validations.entries) {
      if (!entry.value) {
        showSnackBar(context, entry.key);
        return false;
      }
    }
    return true;
  }

// Get height unit and value based on input
  Map<String, dynamic> _getHeightData() {
    if (heightUnit == HeightUnits.ftIn) {
      final heightValue =
          double.parse("${heightFeet.toInt()}.${heightInches.toInt()}");
      return {'unit': 'Ft-in', 'value': heightValue};
    } else {
      return {'unit': 'cm', 'value': heightCm};
    }
  }

// Get weight unit and value based on input
  Map<String, dynamic> _getWeightData() {
    return weightUnit == WeightUnits.kg
        ? {'unit': 'Kg', 'value': weightKg!}
        : {'unit': 'lb', 'value': weightLb!};
  }
}
