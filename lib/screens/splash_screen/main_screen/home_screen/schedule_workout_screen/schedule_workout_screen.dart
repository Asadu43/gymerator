import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/get_workout_plan_cubit/workout_plan_cubit.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exersice_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import 'package:sizer/sizer.dart';

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

  DateTime _selectedValue = DateTime.now();

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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => WorkoutPlanCubit()..getWorkoutRequest(),
      child: BlocConsumer<WorkoutPlanCubit, WorkoutPlanState>(
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      SizedBox(
                        height: screenHeight * 0.13,
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
                              _selectedValue = date;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      const Divider(),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                            "Today’s Report : ${weekdayName[DateTime.now().weekday]}",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      GridView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // Allow scrolling
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1.0,
                                mainAxisSpacing: 1.0,
                                childAspectRatio: 1.2),
                        // itemCount: allProduct?.data?.length ?? 0,
                        itemCount: 7,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (response?.data?.workoutPlan?[index].restDay ==
                                      true &&
                                  weekdayName[DateTime.now().weekday] ==
                                      capitalizeFirstLetter(response
                                              ?.data?.workoutPlan?[index].day ??
                                          "")) {
                                showSnackBar(context, "Rest Day");
                              } else if (response
                                          ?.data?.workoutPlan?[index].restDay ==
                                      false &&
                                  weekdayName[DateTime.now().weekday] ==
                                      capitalizeFirstLetter(response
                                              ?.data?.workoutPlan?[index].day ??
                                          "")) {
                                Nav.push(
                                    context,
                                    ExerciseScreen(
                                        exercises: response!.data!
                                            .workoutPlan![index].exercises!));
                              }

                              // Nav.push(
                              //     context,
                              //     ExerciseScreen(
                              //         exercises: response!.data!
                              //             .workoutPlan![index].exercises!));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Container(
                                      padding: const EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: weekdayName[
                                                    DateTime.now().weekday] ==
                                                capitalizeFirstLetter(response
                                                        ?.data
                                                        ?.workoutPlan?[index]
                                                        .day ??
                                                    "")
                                            ? const Color(0xff599918)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.black12),
                                      ),
                                      child: Center(
                                        child: response?.data?.workoutPlan?[index].restDay == true
                                            ? Text("Rest Day",
                                                style: GoogleFonts.vazirmatn(
                                                    color: weekdayName[DateTime.now().weekday] ==
                                                            capitalizeFirstLetter(
                                                                response?.data?.workoutPlan?[index].day ??
                                                                    "")
                                                        ? Colors.white
                                                        : Colors.black))
                                            : Text("Exercise Day",
                                                style: GoogleFonts.vazirmatn(
                                                    color: weekdayName[DateTime.now().weekday] ==
                                                            capitalizeFirstLetter(response?.data?.workoutPlan?[index].day ?? "")
                                                        ? Colors.white
                                                        : Colors.black)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 1,
                                      left: 50,
                                      child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: weekdayName[DateTime.now()
                                                        .weekday] ==
                                                    capitalizeFirstLetter(
                                                        response
                                                                ?.data
                                                                ?.workoutPlan?[
                                                                    index]
                                                                .day ??
                                                            "")
                                                ? const Color(0xff599918)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.black12),
                                          ),
                                          child: Text(
                                              capitalizeFirstLetter(response
                                                      ?.data
                                                      ?.workoutPlan?[index]
                                                      .day ??
                                                  ""),
                                              style: GoogleFonts.vazirmatn(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: weekdayName[
                                                              DateTime.now()
                                                                  .weekday] ==
                                                          capitalizeFirstLetter(
                                                              response
                                                                      ?.data
                                                                      ?.workoutPlan?[
                                                                          index]
                                                                      .day ??
                                                                  "")
                                                      ? Colors.white
                                                      : Colors.black))))
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
      ),
    );
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}
