import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByDateApiResponse.dart';
import 'package:intl/intl.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../../../../bloC/auth_cubit/all_workout_metrics_cubit/all_workout_metrics_cubit.dart';
import '../../../../../../../models/api_response/GetWorkoutMetricsApiResponse.dart';
import '../../../../../../../utils/nav/nav.dart';

class WorkoutMetricsScreen extends StatefulWidget {
  const WorkoutMetricsScreen({super.key});

  @override
  State<WorkoutMetricsScreen> createState() => _WorkoutMetricsScreenState();
}

class _WorkoutMetricsScreenState extends State<WorkoutMetricsScreen> {
  GetWorkoutMetricsApiResponse? response;
  GetWorkoutMetricsByDateApiResponse? responseByDate;
  String? selectedDate;

  Future<String?> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = formattedDate;
        response = null; // Clear previous all metrics data
        responseByDate = null; // Clear previous date-specific data
      });
      await _onDateButtonPressed(context);
      return formattedDate;
    }
    return null;
  }

  Future<void> _onDateButtonPressed(BuildContext context) async {
    if (selectedDate != null) {
      context.read<AllWorkoutMetricsCubit>().getWorkoutByDateMetricsRequest(
            date: selectedDate!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllWorkoutMetricsCubit()..allWorkoutMetricsRequest(),
      child: BlocConsumer<AllWorkoutMetricsCubit, AllWorkoutMetricsState>(
        listener: (context, state) {
          if (state is FailedToGetWorkoutMetrics) {
            // Handle error state if needed
          }
          if (state is AllWorkoutMetricsSuccessfully) {
            if (selectedDate == null) {
              // Only update if no date is selected
              response = state.response;
            }
          }
          if (state is AllWorkoutMetricsByDateSuccessfully) {
            responseByDate = state.response;
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                            "Workout Metrics",
                            style: GoogleFonts.vazirmatn(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              if (selectedDate != null)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Text(
                                    selectedDate!,
                                    style: GoogleFonts.vazirmatn(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: () => selectDate(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: selectedDate != null
                            ? (responseByDate != null &&
                                    responseByDate!.data != null &&
                                    responseByDate!.data!.isNotEmpty)
                                ? ListView.builder(
                                    itemCount: responseByDate!.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _buildWorkoutCard(
                                          responseByDate!.data![index]);
                                    },
                                  )
                                : Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.h),
                                      child: Text(
                                        "No workout data available for this date",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                            : (response != null &&
                                    response!.data != null &&
                                    response!.data!.isNotEmpty)
                                ? ListView.builder(
                                    itemCount: response!.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _buildWorkoutCard(
                                          response!.data![index]);
                                    },
                                  )
                                : Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.h),
                                      child: Text(
                                        "No workout data available",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
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

  Widget _buildWorkoutCard(dynamic workout) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  workout.exercise ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.vazirmatn(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(color: Colors.black),
              _buildMetricRow(
                  Icons.calendar_month, 'Day : ', workout.day ?? ""),
              SizedBox(height: 8.h),
              _buildMetricRow(Icons.fitbit_rounded, 'Calories : ',
                  "${workout.caloriesBurned}",
                  color: Colors.redAccent),
              SizedBox(height: 8.h),
              _buildMetricRow(Icons.sports_gymnastics, 'Sets: ',
                  "${workout.setsCompleted}"),
              SizedBox(height: 8.h),
              _buildMetricRow(
                  Icons.repeat, 'Reps: ', "${workout.repsCompleted}",
                  color: Colors.red),
              SizedBox(height: 8.h),
              _buildMetricRow(Icons.monitor_weight_outlined, 'Weight : ',
                  "${workout.weightUsed}",
                  color: Colors.red),
              SizedBox(height: 8.h),
              _buildMetricRow(Icons.run_circle_outlined, 'Distance : ',
                  "${workout.distanceCovered}",
                  color: Colors.red),
              SizedBox(height: 8.h),
              _buildMetricRow(Icons.favorite_rounded, 'Heart Rate : ',
                  "${workout.heartRateAvg}",
                  color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(IconData icon, String label, String value,
      {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 10.w),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(fontSize: 12.sp),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.vazirmatn(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
