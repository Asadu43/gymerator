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
import 'exersice_screen/workout_metrics_screen/workout_metrics_screen.dart';

class ScheduleWorkoutScreen extends StatefulWidget {
  const ScheduleWorkoutScreen({super.key});

  @override
  State<ScheduleWorkoutScreen> createState() => _ScheduleWorkoutScreenState();
}

class _ScheduleWorkoutScreenState extends State<ScheduleWorkoutScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;

  GetWorkoutPlanApiResponse? response;

  /// This is the currently selected date from the timeline picker.
  /// We’ll use this to highlight the corresponding day in the Grid.
  DateTime selectedValue = DateTime.now();

  /// Mapping weekday integers to their names
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
                    /// Top Bar with Back Button, Title, Popup Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Nav.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                        Text(
                          "Schedule Workout",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: PopupMenuButton(
                            elevation: 1,
                            position: PopupMenuPosition.under,
                            color: const Color(0xff599918),
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem(
                                  height: 0.05.sh,
                                  onTap: () {
                                    Nav.push(
                                      context,
                                      const UpdateWorkoutPlanScreen(),
                                    );
                                  },
                                  child: Text(
                                    "Update Workout Plan",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.vazirmatn(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  height: 0.05.sh,
                                  onTap: () {
                                    Nav.push(context, const WorkoutMetricsScreen());
                                  },
                                  child: Text(
                                    "Workout Metrics",
                                    style: GoogleFonts.vazirmatn(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 0.02.sh),

                    /// Date Picker Timeline
                    SizedBox(
                      height: 0.13.sh,
                      child: DatePicker(
                        DateTime.now(),
                        daysCount: 7, // Show 7 days in the timeline
                        initialSelectedDate: DateTime.now(),
                        selectionColor: const Color(0xff599918),
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          /// Update the selected date and rebuild the UI
                          setState(() {
                            selectedValue = date;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 0.02.sh),
                    const Divider(),
                    SizedBox(height: 0.02.sh),

                    /// Heading for current selection
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text(
                        // Show the name of the newly selected day
                        "Today’s Report : ${weekdayName[selectedValue.weekday]}",
                        style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.01.sh),

                    /// Grid of Days (Mon-Sun presumably)
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 7, // For 7 days
                      itemBuilder: (context, index) {
                        bool isRestDay = response?.data?.workoutPlan?[index].restDay ?? false;
                        String dayNameFromApi = capitalizeFirstLetter(
                          response?.data?.workoutPlan?[index].day ?? "",
                        );

                        /// Check if this box's day matches the 'selectedValue's day.
                        /// If so, highlight it.
                        bool isSelectedDay =
                            weekdayName[selectedValue.weekday] == dayNameFromApi;

                        return GestureDetector(
                          onTap: () {
                            if (isRestDay) {
                              showSnackBar(context, "Rest Day");
                            } else {
                              if (response?.data?.workoutPlan?[index].exercises != null) {
                                Nav.push(
                                  context,
                                  ExerciseScreen(
                                    exercises:
                                    response!.data!.workoutPlan![index].exercises!,
                                  ),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Stack(
                              children: [
                                /// Main Container for Day / Rest
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                                  child: Container(
                                    padding: EdgeInsets.all(0.01.h),
                                    decoration: BoxDecoration(
                                      color: isSelectedDay
                                          ? const Color(0xff599918).withOpacity(0.5)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Center(
                                      child: isRestDay
                                          ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20.h),
                                          Image.asset("assets/images/rest_day.png"),
                                          SizedBox(height: 10.h),
                                          Text(
                                            "Rest Day",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isSelectedDay
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                          : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20.h),
                                          Image.asset("assets/images/exersise.png"),
                                          SizedBox(height: 20.h),
                                          Text(
                                            "Exercise Day",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: isSelectedDay
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// Box Label at the Top
                                Positioned(
                                  top: 0.001.sh,
                                  left: 0.03.sh,
                                  child: Container(
                                    width: 130.w,
                                    padding: EdgeInsets.all(8.0.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        dayNameFromApi,
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
