import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/exercise_details_cubit/exercise_detail_cubit.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../../ui_component/app_button.dart';
import '../../../../../../../utils/nav/nav.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final Exercises exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  final Health health = Health();
  bool _isAuthorized = false;
  HealthDataPoint? _latestWorkout;
  double _latestHeartRate = 0.0;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Map<int, String> weekdayName = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };


  Future<void> _checkPermissions() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions = await health.hasPermissions([
      HealthDataType.WORKOUT,
      HealthDataType.HEART_RATE,
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ]);

    if (hasPermissions == null || !hasPermissions) {
      try {
        hasPermissions = await health.requestAuthorization([
          HealthDataType.WORKOUT,
          HealthDataType.HEART_RATE,
          HealthDataType.STEPS,
          HealthDataType.ACTIVE_ENERGY_BURNED,
        ]);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }

    setState(() {
      _isAuthorized = hasPermissions ?? false;
    });
  }

  Future<void> _fetchLatestHealthData() async {
    if (!_isAuthorized) {
      await _checkPermissions();
      if (!_isAuthorized) return;
    }

    try {
      final now = DateTime.now();
      final twoMinutesAgo = now.subtract(const Duration(minutes: 2));

      // Fetch latest workout from the last 2 minutes
      List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: twoMinutesAgo,
        endTime: now,
      );

      if (workoutData.isNotEmpty) {
        workoutData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
        _latestWorkout = workoutData.first;
      } else {
        _latestWorkout = null; // Reset if no workout found in the last 2 minutes
      }

      // Fetch latest heart rate from the last 2 minutes
      List<HealthDataPoint> heartRateData = await health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: twoMinutesAgo,
        endTime: now,
      );

      if (heartRateData.isNotEmpty) {
        heartRateData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
        _latestHeartRate =
            (heartRateData.first.value as NumericHealthValue).numericValue.toDouble();
      } else {
        _latestHeartRate = 0.0; // Reset if no heart rate found in the last 2 minutes
      }

      setState(() {});
    } catch (error) {
      debugPrint("Exception in fetchLatestHealthData: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ExerciseDetailCubit(),
  child: BlocConsumer<ExerciseDetailCubit, ExerciseDetailState>(
  listener: (context, state) {
    if(state is FailedToAddMetrics){
      showSnackBar(context, state.response.message ?? "Failed To Add Metrics");
    }if(state is AddMetricsSuccessfully){
      showSnackBar(context, state.response.message ?? "Add Metrics Success fully",type: SnackBarType.success);
    }
  },
  builder: (context, state) {
    return LoadingScreenAnimation(
      isLoading: state is LoadingState,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Nav.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                    SizedBox(width: 0.15.sw),
                    Flexible(
                      child: Text(
                        widget.exercise.exercise ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.vazirmatn(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 0.14.sh,
                      width: 0.27.sw,
                      padding: EdgeInsets.all(16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/icons/clock.png'),
                          SizedBox(height: 5.h),
                          Text(
                            "Sets : ${widget.exercise.sets ?? ""}",
                            style: GoogleFonts.vazirmatn(
                              fontSize: 9.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.14.sh,
                      width: 0.27.sw,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/icons/reps.png'),
                          SizedBox(height: 5.h),
                          Text(
                            "Reps : ${widget.exercise.reps ?? ""}",
                            style: GoogleFonts.vazirmatn(
                              fontSize: 9.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.14.sh,
                      width: 0.27.sw,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/icons/rest.png'),
                          SizedBox(height: 5.h),
                          Text(
                            widget.exercise.rest ?? "",
                            style: GoogleFonts.vazirmatn(
                              fontSize: 9.sp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.02.sh),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Exercise detail",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.vazirmatn(
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _fetchLatestHealthData,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_latestHeartRate > 0)
                        Text(
                          'Latest Heart Rate: ${_latestHeartRate.toStringAsFixed(1)} bpm',
                          style: GoogleFonts.vazirmatn(
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      if (_latestWorkout != null && _latestWorkout!.value is WorkoutHealthValue)
                        _buildWorkoutDetails(_latestWorkout!)
                      else if (_latestHeartRate == 0.0)
                        Text(
                          'No workout or heart rate data found in the last 2 minutes.',
                          style: GoogleFonts.vazirmatn(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: "Get Latest Data (Last 2 Min)",
                  onPressed: _fetchLatestHealthData,
                ),
                const SizedBox(height: 20,),
                if (_latestWorkout != null && _latestWorkout!.value is WorkoutHealthValue) AppButton(
                  text: "Add Your Exercise",
                  onPressed: (){
                    final workoutValue = _latestWorkout?.value as WorkoutHealthValue;
                    int durationInSeconds = _latestWorkout!.dateTo.difference(_latestWorkout!.dateFrom).inSeconds;

                    print(_latestWorkout?.workoutSummary?.totalDistance);
                    print(durationInSeconds);
                    print(weekdayName[DateTime.now().weekday]);
                    print(_latestHeartRate);
                    print(widget.exercise.exercise);
                    print(workoutValue.totalDistance);
                    print(workoutValue.totalEnergyBurned);
                    print(workoutValue.totalSteps);
                   context.read<ExerciseDetailCubit>().addWorkoutMetricsRequest(day: "${weekdayName[DateTime.now().weekday]}", exerciseName: widget.exercise.exercise ?? "", reps: 1, sets: 0, weightUsed: 0, caloriesBurned: workoutValue.totalEnergyBurned ?? 0, duration: durationInSeconds, heartRate: _latestHeartRate, distance: _latestWorkout?.workoutSummary?.totalDistance.toInt() ?? 0, pace: 0);
                  },
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

  Widget _buildWorkoutDetails(HealthDataPoint workout) {
    final workoutValue = workout.value as WorkoutHealthValue;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest Workout: ${workoutValue.workoutActivityType.name}',
              style: GoogleFonts.vazirmatn(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Start: ${workout.dateFrom}',
              style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            Text(
              'End: ${workout.dateTo}',
              style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            if (workoutValue.totalEnergyBurned != null)
              Text(
                'Calories: ${workoutValue.totalEnergyBurned!.toStringAsFixed(1)} ${workoutValue.totalEnergyBurnedUnit?.name ?? "kcal"}',
                style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            if (workoutValue.totalDistance != null)
              Text(
                'Distance: ${(workoutValue.totalDistance! / 1000).toStringAsFixed(2)} km', // Convert meters to kilometers
                style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            if (workoutValue.totalSteps != null)
              Text(
                'Total Steps: ${workoutValue.totalSteps}',
                style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            Text(
              'Source: ${workout.sourceName}',
              style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            Text(
              'Recording Method: ${workout.recordingMethod.name}',
              style: GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}