import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/get_workout_plan_cubit/workout_plan_cubit.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exersice_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/update_workout_plan_screen/update_workout_plan_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import '../../../../../models/api_response/GetWorkoutPlanApiResponse.dart';

class ScheduleWorkoutScreen extends StatefulWidget {
  const ScheduleWorkoutScreen({super.key});

  @override
  State<ScheduleWorkoutScreen> createState() => _ScheduleWorkoutScreenState();
}

class _ScheduleWorkoutScreenState extends State<ScheduleWorkoutScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;
  var selectedTime = '12.30';
  var selectedDate = 19;

  GetWorkoutPlanApiResponse? response;

  DateTime selectedValue = DateTime.now();

  Map<int, String> weekdayName = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };

  @override
  void initState() {
    context.read<WorkoutPlanCubit>().getWorkoutRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutPlanCubit, WorkoutPlanState>(
      listener: (context, state) {
        if (state is FailedToGetWorkoutPlan) {
          showSnackBar(context, "Failed to Get Workout Plan");
        }
        if (state is GetWorkoutSuccessfully) {
          response = state.response;
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Nav.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        Text("Schedule Workout",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Container(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                            elevation: 1,
                            position: PopupMenuPosition.under,
                            color: const Color(0xff599918),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  height: 0.05.sh,
                                  onTap: () {
                                    Nav.push(context,
                                        const UpdateWorkoutPlanScreen());
                                  },
                                  child: Center(
                                    child: Text("Update Workout Plan",
                                        style: GoogleFonts.vazirmatn(
                                            color: Colors.white,
                                            fontSize: 16.sp)),
                                  ),
                                ),
                                // Add more actions to the menu here if needed
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    SizedBox(
                      height: 0.13.sh,
                      child: DatePicker(
                        DateTime.now(),
                        daysCount: 7,
                        // inactiveDates: [
                        //   // DateTime.sunday,
                        // ],
                        initialSelectedDate: DateTime.now(),
                        selectionColor: const Color(0xff599918),
                        selectedTextColor: Colors.white,

                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            selectedValue = date;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 12.w),
                      child: Text(
                          "Today’s Report : ${weekdayName[DateTime.now().weekday]}",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      // Allow scrolling
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              childAspectRatio: 1.0),
                      // itemCount: allProduct?.data?.length ?? 0,
                      itemCount: 7,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (response?.data?.workoutPlan?[index].restDay ==
                                true) {
                              showSnackBar(context, "Rest Day");
                            } else {
                              Nav.push(
                                  context,
                                  ExerciseScreen(
                                      exercises: response!.data!
                                          .workoutPlan![index].exercises!));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.03.sh),
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(0.01.h),
                                    decoration: BoxDecoration(
                                      color:
                                          weekdayName[DateTime.now().weekday] ==
                                                  capitalizeFirstLetter(response
                                                          ?.data
                                                          ?.workoutPlan?[index]
                                                          .day ??
                                                      "")
                                              ? const Color(0xff599918)
                                                  .withOpacity(0.5)
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Center(
                                      child: response?.data?.workoutPlan?[index]
                                                  .restDay ==
                                              true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 20.h),
                                                Image.asset(
                                                    "assets/images/rest_day.png"),
                                                 SizedBox(height: 10.h),
                                                Text("Rest Day",
                                                    style: GoogleFonts.vazirmatn(
                                                        fontSize: 14.sp,
                                                        color: weekdayName[DateTime
                                                                        .now()
                                                                    .weekday] ==
                                                                capitalizeFirstLetter(response
                                                                        ?.data
                                                                        ?.workoutPlan?[
                                                                            index]
                                                                        .day ??
                                                                    "")
                                                            ? Colors.white
                                                            : Colors.black)),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 20.h),
                                                Image.asset(
                                                    "assets/images/exersise.png"),
                                                SizedBox(height: 20.h),
                                                Text("Exercise Day",
                                                    style: GoogleFonts.vazirmatn(
                                                        fontSize: 14.sp,
                                                        color: weekdayName[DateTime
                                                                        .now()
                                                                    .weekday] ==
                                                                capitalizeFirstLetter(response
                                                                        ?.data
                                                                        ?.workoutPlan?[
                                                                            index]
                                                                        .day ??
                                                                    "")
                                                            ? Colors.white
                                                            : Colors.black)),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 0.001.sh,
                                    left: 0.03.sh,
                                    child: Container(
                                        width: 130.w,
                                        padding:  EdgeInsets.all(8.0.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: Center(
                                          child: Text(
                                              capitalizeFirstLetter(response
                                                      ?.data
                                                      ?.workoutPlan?[index]
                                                      .day ??
                                                  ""),
                                              style: GoogleFonts.vazirmatn(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        )))
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
