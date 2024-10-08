import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/workout_plan_screen/workout_plan_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';

class CompleteSetup extends StatefulWidget {
  final String gender;
  final String heightUnit;
  final double heightValue;
  final String weightUnit;
  final double weightValue;
  final int age;
  final int goal;
  final int plan;
  final String sleepHours;
  final String mealFrequency;
  final String hydrationDaily;
  final String targetWeight;
  final int dietPlan;
  final String selectMedicalName;
  final String medicalCondition;

  const CompleteSetup(
      {super.key,
      required this.gender,
      required this.heightUnit,
      required this.heightValue,
      required this.weightUnit,
      required this.weightValue,
      required this.age,
      required this.goal,
      required this.plan,
      required this.sleepHours,
      required this.mealFrequency,
      required this.hydrationDaily,
      required this.targetWeight,
      required this.dietPlan,
      required this.selectMedicalName,
      required this.medicalCondition});

  @override
  State<CompleteSetup> createState() => _CompleteSetupState();
}

class _CompleteSetupState extends State<CompleteSetup> {
  String percent = "0.0%";
  double percentage = 0.0;
  bool isButtonActive = false;
  bool isLoading = false;
  // late String name = '';

  @override
  void initState() {
    super.initState();
    percent = "50.0%";
    percentage = 0.50;

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        percent = "100.0%";
        percentage = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UpdateUserInfoCubit(),
      child: BlocConsumer<UpdateUserInfoCubit, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is FailedToUpdateUserInfo) {
            showSnackBar(context, state.message);
          }
          if (state is UpdateUserSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            Nav.pushAndRemoveAllRoute(context, const WorkoutPlanScreen());
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
                body: Container(
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
                      "We Creating Your \nWorkout Plan",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vazirmatn(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
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
                      linearGradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // stops: const [0.0, 1.0],
                        colors: [
                          Color(0xffB14501),
                          Color(0xff3F710D),
                        ],
                      ),
                      // percent: percentage,
                      percent: percentage,
                      center: Text(
                        percent,
                        style: GoogleFonts.vazirmatn(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: AppColors.white),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      // progressColor: AppColors.prductBuyNowButtonColor,
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      (percentage == 1) ? "Completed" : "Please Wait",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vazirmatn(
                          fontSize: 13.sp, color: AppColors.white),
                    ),
                    const Spacer(),
                    (percentage == 1)
                        ? AppButton(
                            text: "Start Training",
                            onPressed: () async {
                              await _savePressButtonPressed(context);
                              // Nav.push(context, const MainScreen());
                            },
                          )
                        : const SizedBox(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }

  Future<void> _savePressButtonPressed(BuildContext context) async {
    context.read<UpdateUserInfoCubit>().updateInfoRequest(
        gender: widget.gender,
        heightUnit: widget.heightUnit,
        heightValue: widget.heightValue,
        weightUnit: widget.weightUnit,
        weightValue: widget.weightValue,
        age: widget.age,
        goal: widget.goal,
        workoutLevel: widget.plan - 1,
        sleepHours: int.parse(widget.sleepHours),
        mealFrequency: int.parse(widget.mealFrequency),
        hydrationDaily: int.parse(widget.hydrationDaily),
        targetWeight: int.parse(widget.targetWeight),
        dietPlan: widget.dietPlan,
        selectMedicalName: widget.selectMedicalName,
        medicalCondition: widget.medicalCondition);
  }
}
