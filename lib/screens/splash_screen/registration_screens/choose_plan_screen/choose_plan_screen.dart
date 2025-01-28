import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import '../../../../bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../workout_plan_screen/workout_plan_screen.dart';

class ChoosePlanScreen extends StatefulWidget {
  final String gender;
  final String heightUnit;
  final double heightValue;
  final String weightUnit;
  final double weightValue;
  final String age;
  final int goal;
  final String sleepHours;
  final String mealFrequency;
  final String hydrationDaily;
  final String targetWeight;
  final int dietPlan;
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
      required this.dietPlan,
      required this.selectMedicalName,
      required this.medicalCondition});

  @override
  State<ChoosePlanScreen> createState() => _ChoosePlanScreenState();
}

class _ChoosePlanScreenState extends State<ChoosePlanScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;

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
            Nav.pushAndRemoveAllRoute(context, const WorkoutPlanScreen());
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: Container(
                height: 1.sh, // Full screen height
                width: 1.sw, // Full screen width
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.07.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 1.sh / 12),
                      SizedBox(height: 0.03.sh),
                      Text(
                        "Choose Your Plan",
                        style: GoogleFonts.vazirmatn(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        "Your coach will design a weight loss plan for you to suit you best",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vazirmatn(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 0.03.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPlanColumn(
                            context,
                            "Beginner",
                            "5-10 mins a day",
                            "assets/images/begginer.png",
                            1,
                          ),
                          buildPlanColumn(
                            context,
                            "Intermediate",
                            "10-20 mins a day",
                            "assets/images/intermedate.png",
                            2,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.03.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildPlanColumn(
                            context,
                            "Advance",
                            "15-30 mins a day",
                            "assets/images/advance.png",
                            3,
                          ),
                          buildPlanColumn(
                            context,
                            "Expert",
                            "20-35 mins a day",
                            "assets/images/expert.png",
                            4,
                          ),
                        ],
                      ),
                      const Spacer(),
                      AppButton(
                        text: "Generate Plan",
                        onPressed: () async {
                          if (selectedIndex == 0) {
                            showSnackBar(context, "Please select plan");
                          } else {
                            await _savePressButtonPressed(context);
                          }
                        },
                      ),
                      SizedBox(height: 10.h), // Responsive bottom spacing
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

  Widget buildPlanColumn(BuildContext context, String title, String subtitle,
      String imagePath, int planIndex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 0.18.sh,
          width: 0.4.sw,
          decoration: BoxDecoration(
            gradient: (checkboxValue == true && selectedIndex == planIndex)
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffB14501), Color(0xff3F710D)],
                  )
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.transparent, Colors.transparent],
                  ),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                if ((checkboxValue == true) && (selectedIndex == planIndex)) {
                  checkboxValue = false;
                  selectedIndex = 0;
                } else {
                  checkboxValue = true;
                  selectedIndex = planIndex;
                }
              });
            },
            child: Image.asset(imagePath),
          ),
        ),
        SizedBox(height: 0.02.sh),
        Text(
          title,
          style: GoogleFonts.vazirmatn(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color:(checkboxValue == true && selectedIndex == planIndex) ?  const Color(0xff3F710D) : Colors.white,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.vazirmatn(
            fontSize: 10.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Future<void> _savePressButtonPressed(BuildContext context) async {
    context.read<UpdateUserInfoCubit>().updateInfoRequest(
        gender: widget.gender,
        heightUnit: widget.heightUnit,
        heightValue: widget.heightValue,
        weightUnit: widget.weightUnit,
        weightValue: widget.weightValue,
        age: int.parse(widget.age),
        goal: widget.goal,
        workoutLevel: selectedIndex - 1,
        sleepHours: int.parse(widget.sleepHours),
        mealFrequency: int.parse(widget.mealFrequency),
        hydrationDaily: int.parse(widget.hydrationDaily),
        targetWeight: int.parse(widget.targetWeight),
        dietPlan: widget.dietPlan,
        selectMedicalName: widget.selectMedicalName,
        medicalCondition: widget.medicalCondition);
  }
}
