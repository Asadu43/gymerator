import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/exercise_details_cubit/exercise_detail_cubit.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/instructions_for_android.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/workout_detail_activity_screen/util.dart';
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

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
  HEALTH_CONNECT_STATUS,
  PERMISSIONS_REVOKING,
  PERMISSIONS_REVOKED,
  PERMISSIONS_NOT_REVOKED,
  CALORIES_READY,
  HEART_RATE_READY,
  LAST_THREE_MINUTES_READY,
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  final Health health = Health();
  bool _isAuthorized = false;
  HealthDataPoint? _latestWorkout;
  double _latestHeartRate = 0.0;

  AppState _state = AppState.DATA_NOT_FETCHED;
  List<RecordingMethod> recordingMethodsToFilter = [];

  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  List<HealthDataAccess> get permissions => types
      .map((type) => [
            HealthDataType.WALKING_HEART_RATE,
            HealthDataType.ELECTROCARDIOGRAM,
            HealthDataType.HIGH_HEART_RATE_EVENT,
            HealthDataType.LOW_HEART_RATE_EVENT,
            HealthDataType.IRREGULAR_HEART_RATE_EVENT,
            HealthDataType.EXERCISE_TIME,
          ].contains(type)
              ? HealthDataAccess.READ
              : HealthDataAccess.READ_WRITE)
      .toList();

  @override
  void initState() {
    super.initState();
    health.configure();
    _checkPermissionsOnInit();
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

  Future<void> _checkPermissionsOnInit() async {
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);
    if (hasPermissions ?? false) {
      setState(() {
        _isAuthorized = true;
        _state = AppState.AUTHORIZED;
      });
    }
  }

  Future<void> authorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        debugPrint("Exception in authorize: $error");
      }
    }

    setState(() {
      _state = (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;
      _isAuthorized = authorized;
    });
  }

  Future<void> fetchLatestData() async {
    setState(() => _state = AppState.FETCHING_DATA);

    bool permission = await health.hasPermissions([
          HealthDataType.WORKOUT,
          HealthDataType.HEART_RATE,
        ]) ??
        false;

    if (!permission) {
      permission = await health.requestAuthorization([
        HealthDataType.WORKOUT,
        HealthDataType.HEART_RATE,
      ]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final threeHoursAgo = now.subtract(const Duration(minutes: 2));

        // Fetch workout data
        List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
          types: [HealthDataType.WORKOUT],
          startTime: threeHoursAgo,
          endTime: now,
        );

        // Fetch heart rate data
        List<HealthDataPoint> heartRateData =
            await health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: threeHoursAgo,
          endTime: now,
        );

        setState(() {
          if (workoutData.isNotEmpty) {
            workoutData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
            _latestWorkout = workoutData.first;
          } else {
            _latestWorkout = null;
          }

          if (heartRateData.isNotEmpty) {
            heartRateData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
            _latestHeartRate = (heartRateData.first.value as NumericHealthValue)
                .numericValue
                .toDouble();
          } else {
            _latestHeartRate = 0.0;
          }

          _state = AppState.LAST_THREE_MINUTES_READY;
        });
      } catch (error) {
        debugPrint("Exception in fetchLatestData: $error");
        setState(() => _state = AppState.NO_DATA);
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.AUTH_NOT_GRANTED);
    }
  }

  Future<void> revokeAccess() async {
    setState(() => _state = AppState.PERMISSIONS_REVOKING);
    bool success = false;
    try {
      await health.revokePermissions();
      success = true;
    } catch (error) {
      debugPrint("Exception in revokeAccess: $error");
    }
    setState(() {
      _state = success
          ? AppState.PERMISSIONS_REVOKED
          : AppState.PERMISSIONS_NOT_REVOKED;
      if (success) {
        _isAuthorized = false;
        _latestWorkout = null;
        _latestHeartRate = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseDetailCubit(),
      child: BlocConsumer<ExerciseDetailCubit, ExerciseDetailState>(
        listener: (context, state) {
          if (state is FailedToAddMetrics) {
            showSnackBar(
                context, state.response.message ?? "Failed To Add Metrics");
          }
          if (state is AddMetricsSuccessfully) {
            showSnackBar(
                context, state.response.message ?? "Add Metrics Success fully",
                type: SnackBarType.success);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading:
                state is LoadingState || _state == AppState.FETCHING_DATA,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!_isAuthorized) ...[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.4.sh),
                            child: AppButton(
                              text: "Authorize",
                              onPressed: authorize,
                            ),
                          ),
                        ),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Nav.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                            // SizedBox(width: 0.15.sw),
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
                                      onTap: revokeAccess,
                                      child: Center(
                                        child: Text(
                                          "Revoke Access",
                                          style: GoogleFonts.vazirmatn(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (Platform
                                        .isAndroid) // Condition to show only on Android
                                      PopupMenuItem(
                                        height: 0.05.sh,
                                        onTap: () {
                                          Nav.push(context,
                                              const InstructionsForAndroidScreen());
                                        },
                                        child: Center(
                                          child: Text(
                                            "Instructions for Android",
                                            style: GoogleFonts.vazirmatn(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ];
                                },
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
                                border: Border.all(
                                    color: Colors.grey[300]!, width: 1),
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
                                border: Border.all(
                                    color: Colors.grey[300]!, width: 1),
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
                                border: Border.all(
                                    color: Colors.grey[300]!, width: 1),
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
                              onPressed: fetchLatestData,
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_state == AppState.LAST_THREE_MINUTES_READY)
                                Column(
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
                                    if (_latestWorkout != null &&
                                        _latestWorkout!.value
                                            is WorkoutHealthValue)
                                      _buildWorkoutDetails(_latestWorkout!)
                                    else if (_latestHeartRate == 0.0 &&
                                        _latestWorkout == null)
                                      Text(
                                        'No workout or heart rate data found in the last 2 minutes.',
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                )
                              else if (_state == AppState.NO_DATA)
                                Text(
                                  'No data available',
                                  style: GoogleFonts.vazirmatn(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(height: 20.h),
                        if (_latestWorkout != null &&
                            _latestWorkout!.value is WorkoutHealthValue)
                          AppButton(
                            text: "Add Your Exercise",
                            onPressed: () {
                              final workoutValue =
                                  _latestWorkout!.value as WorkoutHealthValue;
                              int durationInSeconds = _latestWorkout!.dateTo
                                  .difference(_latestWorkout!.dateFrom)
                                  .inSeconds;

                              context
                                  .read<ExerciseDetailCubit>()
                                  .addWorkoutMetricsRequest(
                                    day:
                                        "${weekdayName[DateTime.now().weekday]}",
                                    exerciseName:
                                        widget.exercise.exercise ?? "",
                                    reps: 1,
                                    sets: 0,
                                    weightUsed: 0,
                                    caloriesBurned:
                                        (workoutValue.totalEnergyBurned ?? 0) *
                                            10000,
                                    duration: durationInSeconds,
                                    heartRate: _latestHeartRate,
                                    distance:
                                        workoutValue.totalDistance?.toInt() ??
                                            0,
                                    pace: 0,
                                  );
                            },
                          ),
                      ],
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
              style:
                  GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            Text(
              'End: ${workout.dateTo}',
              style:
                  GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            if (workoutValue.totalEnergyBurned != null)
              Text(
                'Calories: ${workoutValue.totalEnergyBurned!.toStringAsFixed(1)} ${workoutValue.totalEnergyBurnedUnit?.name ?? "kcal"}',
                style:
                    GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            if (workoutValue.totalDistance != null)
              Text(
                'Distance: ${(workoutValue.totalDistance! / 1000).toStringAsFixed(2)} km',
                style:
                    GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            if (workoutValue.totalSteps != null)
              Text(
                'Total Steps: ${workoutValue.totalSteps}',
                style:
                    GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
              ),
            Text(
              'Source: ${workout.sourceName}',
              style:
                  GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
            Text(
              'Recording Method: ${workout.recordingMethod.name}',
              style:
                  GoogleFonts.vazirmatn(fontSize: 14.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
