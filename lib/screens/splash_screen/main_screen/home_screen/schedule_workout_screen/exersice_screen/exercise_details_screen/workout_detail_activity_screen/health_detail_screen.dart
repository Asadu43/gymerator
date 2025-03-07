import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/workout_detail_activity_screen/util.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';


class HealthApp extends StatefulWidget {
  const HealthApp({super.key});

  @override
  HealthAppState createState() => HealthAppState();
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
  ELLIPTICAL_WORKOUT_READY,
  GYMNASTICS_WORKOUT_READY,
  ALL_EXERCISES_READY,
}

class HealthAppState extends State<HealthApp> {
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  int _nofSteps = 0;
  double _caloriesBurned = 0.0;
  double _latestHeartRate = 0.0;
  int _lastThreeMinSteps = 0;
  double _lastThreeMinCalories = 0.0;
  List<HealthDataPoint> _ellipticalWorkouts = [];
  List<HealthDataPoint> _gymnasticsWorkouts = [];
  List<HealthDataPoint> _allExercises = [];
  List<RecordingMethod> recordingMethodsToFilter = [];
  final health = Health();

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
    health.configure();
    health.getHealthConnectSdkStatus();
    super.initState();
  }

  Future<void> installHealthConnect() async =>
      await health.installHealthConnect();

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

    setState(() => _state =
    (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED);
  }

  Future<void> getHealthConnectSdkStatus() async {
    assert(Platform.isAndroid, "This is only available on Android");

    final status = await health.getHealthConnectSdkStatus();

    setState(() {
      _contentHealthConnectStatus =
          Text('Health Connect Status: ${status?.name.toUpperCase()}');
      _state = AppState.HEALTH_CONNECT_STATUS;
    });
  }

  Future<void> fetchStepData() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool stepsPermission = await health.hasPermissions(
        [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED]) ??
        false;
    if (!stepsPermission) {
      stepsPermission = await health.requestAuthorization([
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED
      ]);
    }

    if (stepsPermission) {
      try {
        int? steps = await health.getTotalStepsInInterval(midnight, now,
            includeManualEntry:
            !recordingMethodsToFilter.contains(RecordingMethod.manual));

        List<HealthDataPoint> caloriesData = await health.getHealthDataFromTypes(
          types: [HealthDataType.ACTIVE_ENERGY_BURNED],
          startTime: midnight,
          endTime: now,
        );

        double calories = 0;
        for (var data in caloriesData) {
          calories += (data.value as NumericHealthValue).numericValue.toDouble();
        }

        debugPrint('Today\'s steps: $steps');
        debugPrint('Today\'s calories burned: $calories kcal');

        setState(() {
          _nofSteps = steps ?? 0;
          _caloriesBurned = calories;
          _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
        });
      } catch (error) {
        debugPrint("Exception in fetchStepData: $error");
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchTotalCalories() async {
    bool permission = await health
        .hasPermissions([HealthDataType.ACTIVE_ENERGY_BURNED]) ??
        false;
    if (!permission) {
      permission = await health
          .requestAuthorization([HealthDataType.ACTIVE_ENERGY_BURNED]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final weekAgo = now.subtract(Duration(days: 7));

        List<HealthDataPoint> caloriesData = await health.getHealthDataFromTypes(
          types: [HealthDataType.ACTIVE_ENERGY_BURNED],
          startTime: weekAgo,
          endTime: now,
        );

        double totalCalories = 0;
        for (var data in caloriesData) {
          totalCalories +=
              (data.value as NumericHealthValue).numericValue.toDouble();
        }

        setState(() {
          _caloriesBurned = totalCalories;
          _state = AppState.CALORIES_READY;
        });
      } catch (error) {
        debugPrint("Exception in fetchTotalCalories: $error");
      }
    }
  }

  Future<void> fetchLatestHeartRate() async {
    bool permission =
        await health.hasPermissions([HealthDataType.HEART_RATE]) ?? false;
    if (!permission) {
      permission =
      await health.requestAuthorization([HealthDataType.HEART_RATE]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final yesterday = now.subtract(Duration(days: 1));

        List<HealthDataPoint> heartRateData = await health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: yesterday,
          endTime: now,
        );

        if (heartRateData.isNotEmpty) {
          heartRateData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
          double latestHR =
          (heartRateData.first.value as NumericHealthValue).numericValue.toDouble();

          setState(() {
            _latestHeartRate = latestHR;
            _state = AppState.HEART_RATE_READY;
          });
        } else {
          setState(() => _state = AppState.NO_DATA);
        }
      } catch (error) {
        debugPrint("Exception in fetchLatestHeartRate: $error");
      }
    }
  }

  Future<void> fetchLastThreeMinutesData() async {
    bool permission = await health.hasPermissions(
        [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED]) ??
        false;
    if (!permission) {
      permission = await health.requestAuthorization([
        HealthDataType.STEPS,
        HealthDataType.ACTIVE_ENERGY_BURNED
      ]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final threeMinutesAgo = now.subtract(Duration(minutes: 3));

        int? steps = await health.getTotalStepsInInterval(threeMinutesAgo, now,
            includeManualEntry:
            !recordingMethodsToFilter.contains(RecordingMethod.manual));

        List<HealthDataPoint> caloriesData = await health.getHealthDataFromTypes(
          types: [HealthDataType.ACTIVE_ENERGY_BURNED],
          startTime: threeMinutesAgo,
          endTime: now,
        );

        double calories = 0;
        for (var data in caloriesData) {
          calories += (data.value as NumericHealthValue).numericValue.toDouble();
        }

        debugPrint('Last 3 minutes steps: $steps');
        debugPrint('Last 3 minutes calories burned: $calories kcal');

        setState(() {
          _lastThreeMinSteps = steps ?? 0;
          _lastThreeMinCalories = calories;
          _state = (steps == null)
              ? AppState.NO_DATA
              : AppState.LAST_THREE_MINUTES_READY;
        });
      } catch (error) {
        debugPrint("Exception in fetchLastThreeMinutesData: $error");
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchEllipticalWorkout() async {
    bool permission = await health.hasPermissions([HealthDataType.WORKOUT]) ?? false;
    if (!permission) {
      permission = await health.requestAuthorization([HealthDataType.WORKOUT]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day);

        List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
          types: [HealthDataType.WORKOUT],
          startTime: midnight,
          endTime: now,
        );

        _ellipticalWorkouts.clear();
        for (var data in workoutData) {
          if (data.value is WorkoutHealthValue) {
            final workoutValue = data.value as WorkoutHealthValue;
            if (workoutValue.workoutActivityType == HealthWorkoutActivityType.ELLIPTICAL) {
              _ellipticalWorkouts.add(data);
            }
          }
        }

        debugPrint('Found ${_ellipticalWorkouts.length} elliptical workouts today');

        setState(() {
          _state = _ellipticalWorkouts.isNotEmpty
              ? AppState.ELLIPTICAL_WORKOUT_READY
              : AppState.NO_DATA;
        });
      } catch (error) {
        debugPrint("Exception in fetchEllipticalWorkout: $error");
        setState(() => _state = AppState.NO_DATA);
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchGymnasticsWorkout() async {
    bool permission = await health.hasPermissions([HealthDataType.WORKOUT]) ?? false;
    if (!permission) {
      permission = await health.requestAuthorization([HealthDataType.WORKOUT]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day);

        List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
          types: [HealthDataType.WORKOUT],
          startTime: midnight,
          endTime: now,
        );

        _gymnasticsWorkouts.clear();
        for (var data in workoutData) {
          if (data.value is WorkoutHealthValue) {
            final workoutValue = data.value as WorkoutHealthValue;
            if (workoutValue.workoutActivityType == HealthWorkoutActivityType.GYMNASTICS) {
              _gymnasticsWorkouts.add(data);
            }
          }
        }

        debugPrint('Found ${_gymnasticsWorkouts.length} gymnastics workouts today');

        setState(() {
          _state = _gymnasticsWorkouts.isNotEmpty
              ? AppState.GYMNASTICS_WORKOUT_READY
              : AppState.NO_DATA;
        });
      } catch (error) {
        debugPrint("Exception in fetchGymnasticsWorkout: $error");
        setState(() => _state = AppState.NO_DATA);
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Future<void> fetchAllExercises() async {
    bool permission = await health.hasPermissions([HealthDataType.WORKOUT]) ?? false;
    if (!permission) {
      permission = await health.requestAuthorization([HealthDataType.WORKOUT]);
    }

    if (permission) {
      try {
        final now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day);

        List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
          types: [HealthDataType.WORKOUT],
          startTime: midnight,
          endTime: now,
        );

        _allExercises.clear();
        _allExercises.addAll(workoutData);

        debugPrint('Found ${_allExercises.length} exercises today');

        setState(() {
          _state = _allExercises.isNotEmpty
              ? AppState.ALL_EXERCISES_READY
              : AppState.NO_DATA;
        });
      } catch (error) {
        debugPrint("Exception in fetchAllExercises: $error");
        setState(() => _state = AppState.NO_DATA);
      }
    } else {
      debugPrint("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Column(
          children: [
            Wrap(
              spacing: 10,
              children: [
                if (Platform.isAndroid)
                  TextButton(
                      onPressed: getHealthConnectSdkStatus,
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: const Text("Check Health Connect Status",
                          style: TextStyle(color: Colors.white))),
                if (Platform.isAndroid &&
                    health.healthConnectSdkStatus !=
                        HealthConnectSdkStatus.sdkAvailable)
                  TextButton(
                      onPressed: installHealthConnect,
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: const Text("Install Health Connect",
                          style: TextStyle(color: Colors.white))),
                if (Platform.isIOS ||
                    Platform.isAndroid &&
                        health.healthConnectSdkStatus ==
                            HealthConnectSdkStatus.sdkAvailable)
                  Wrap(spacing: 10, children: [
                    TextButton(
                        onPressed: authorize,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Authenticate",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchStepData,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Fetch Step Data",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchTotalCalories,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Total Calories",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchLatestHeartRate,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Latest Heart Rate",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchLastThreeMinutesData,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Last 3 Min Data",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchEllipticalWorkout,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Elliptical",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchGymnasticsWorkout,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Gymnastics",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: fetchAllExercises,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("All Exercises",
                            style: TextStyle(color: Colors.white))),
                    TextButton(
                        onPressed: revokeAccess,
                        style: const ButtonStyle(
                            backgroundColor:
                            WidgetStatePropertyAll(Colors.blue)),
                        child: const Text("Revoke Access",
                            style: TextStyle(color: Colors.white))),
                  ]),
              ],
            ),
            const Divider(thickness: 3),
            if (_state == AppState.DATA_READY) _dataFiltration,
            if (_state == AppState.STEPS_READY || _state == AppState.LAST_THREE_MINUTES_READY)
              _stepsFiltration,
            Expanded(child: Center(child: _content))
          ],
        ),
      ),
    );
  }

  Widget get _dataFiltration => Column(
    children: [
      Wrap(
        children: [
          for (final method in Platform.isAndroid
              ? [
            RecordingMethod.manual,
            RecordingMethod.automatic,
            RecordingMethod.active,
            RecordingMethod.unknown,
          ]
              : [
            RecordingMethod.automatic,
            RecordingMethod.manual,
          ])
            SizedBox(
              width: 150,
              child: CheckboxListTile(
                title: Text(
                    '${method.name[0].toUpperCase()}${method.name.substring(1)} entries'),
                value: !recordingMethodsToFilter.contains(method),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      recordingMethodsToFilter.remove(method);
                    } else {
                      recordingMethodsToFilter.add(method);
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
        ],
      ),
      const Divider(thickness: 3),
    ],
  );

  Widget get _stepsFiltration => Column(
    children: [
      Wrap(
        children: [
          for (final method in [
            RecordingMethod.manual,
          ])
            SizedBox(
              width: 150,
              child: CheckboxListTile(
                title: Text(
                    '${method.name[0].toUpperCase()}${method.name.substring(1)} entries'),
                value: !recordingMethodsToFilter.contains(method),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      recordingMethodsToFilter.remove(method);
                    } else {
                      recordingMethodsToFilter.add(method);
                    }
                    if (_state == AppState.STEPS_READY) {
                      fetchStepData();
                    } else if (_state == AppState.LAST_THREE_MINUTES_READY) {
                      fetchLastThreeMinutesData();
                    }
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
        ],
      ),
      const Divider(thickness: 3),
    ],
  );

  Widget get _permissionsRevoking => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          padding: const EdgeInsets.all(20),
          child: const CircularProgressIndicator(
            strokeWidth: 10,
          )),
      const Text('Revoking permissions...')
    ],
  );

  Widget get _permissionsRevoked => const Text('Permissions revoked.');

  Widget get _permissionsNotRevoked =>
      const Text('Failed to revoke permissions');

  Widget get _contentFetchingData => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          padding: const EdgeInsets.all(20),
          child: const CircularProgressIndicator(
            strokeWidth: 10,
          )),
      const Text('Fetching data...')
    ],
  );

  Widget get _contentDataReady => ListView.builder(
      itemCount: _healthDataList.length,
      itemBuilder: (_, index) {
        if (recordingMethodsToFilter
            .contains(_healthDataList[index].recordingMethod)) {
          return Container();
        }

        HealthDataPoint p = _healthDataList[index];
        if (p.value is AudiogramHealthValue) {
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text(p.unitString),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }
        if (p.value is WorkoutHealthValue) {
          return ListTile(
            title: Text(
                "${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}"),
            trailing:
            Text((p.value as WorkoutHealthValue).workoutActivityType.name),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }
        if (p.value is NutritionHealthValue) {
          return ListTile(
            title: Text(
                "${p.typeString} ${(p.value as NutritionHealthValue).mealType}: ${(p.value as NutritionHealthValue).name}"),
            trailing:
            Text('${(p.value as NutritionHealthValue).calories} kcal'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
          );
        }
        return ListTile(
          title: Text("${p.typeString}: ${p.value}"),
          trailing: Text(p.unitString),
          subtitle: Text('${p.dateFrom} - ${p.dateTo}\n${p.recordingMethod}'),
        );
      });

  final Widget _contentNoData = const Text('No Data to show');

  final Widget _contentNotFetched =
  const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Text("Press 'Auth' to get permissions to access health data."),
    Text("Press 'Fetch Step Data' to get today's steps and calories."),
    Text("Press 'Total Calories' to get total calories burned."),
    Text("Press 'Latest Heart Rate' to get recent heart rate."),
    Text("Press 'Last 3 Min Data' to get last 3 minutes data."),
    Text("Press 'Elliptical' to get today's elliptical workout details."),
    Text("Press 'Gymnastics' to get today's gymnastics workout details."),
    Text("Press 'All Exercises' to get all exercise details for today."),
  ]);

  final Widget _authorized = const Text('Authorization granted!');

  final Widget _authorizationNotGranted = const Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Authorization not given.'),
      Text(
          'For Google Health Connect please check if you have added the right permissions and services to the manifest file.'),
      Text('For Apple Health check your permissions in Apple Health.'),
    ],
  );

  Widget _contentHealthConnectStatus = const Text(
      'No status, click getHealthConnectSdkStatus to get the status.');

  final Widget _dataAdded = const Text('Data points inserted successfully.');

  final Widget _dataDeleted = const Text('Data points deleted successfully.');

  Widget get _stepsFetched => Column(
    children: [
      Text('Today\'s Steps: $_nofSteps'),
      Text('Calories Burned Today: ${_caloriesBurned.toStringAsFixed(1)} kcal'),
    ],
  );

  Widget get _caloriesFetched => Text(
      'Total Calories Burned (7 days): ${_caloriesBurned.toStringAsFixed(1)} kcal');

  Widget get _heartRateFetched =>
      Text('Latest Heart Rate: ${_latestHeartRate.toStringAsFixed(1)} bpm');

  Widget get _lastThreeMinutesFetched => Column(
    children: [
      Text('Last 3 Minutes Steps: $_lastThreeMinSteps'),
      Text(
          'Last 3 Minutes Calories: ${_lastThreeMinCalories.toStringAsFixed(1)} kcal'),
    ],
  );

  Widget get _ellipticalWorkoutFetched => ListView.builder(
    itemCount: _ellipticalWorkouts.length,
    itemBuilder: (_, index) {
      final workout = _ellipticalWorkouts[index];
      final workoutValue = workout.value as WorkoutHealthValue;

      return Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Elliptical Workout #${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Start Time: ${workout.dateFrom}'),
              Text('End Time: ${workout.dateTo}'),
              Text('Calories Burned: ${workoutValue.totalEnergyBurned?.toStringAsFixed(1) ?? "N/A"} kcal'),
              Text('Distance: ${workoutValue.totalDistance?.toStringAsFixed(1) ?? "N/A"} ${workoutValue.totalDistanceUnit?.name ?? ""}'),
              Text('Recording Method: ${workout.recordingMethod.name}'),
              Text('Title: ${workoutValue.workoutActivityType.name}'),
            ],
          ),
        ),
      );
    },
  );

  Widget get _gymnasticsWorkoutFetched => ListView.builder(
    itemCount: _gymnasticsWorkouts.length,
    itemBuilder: (_, index) {
      final workout = _gymnasticsWorkouts[index];
      final workoutValue = workout.value as WorkoutHealthValue;

      return Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gymnastics Workout #${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Start Time: ${workout.dateFrom}'),
              Text('End Time: ${workout.dateTo}'),
              Text('Calories Burned: ${workoutValue.totalEnergyBurned?.toStringAsFixed(1) ?? "N/A"} kcal'),
              Text('Distance: ${workoutValue.totalDistance?.toStringAsFixed(1) ?? "N/A"} ${workoutValue.totalDistanceUnit?.name ?? ""}'),
              Text('Recording Method: ${workout.recordingMethod.name}'),
              Text('Title: ${workoutValue.workoutActivityType.name}'),
            ],
          ),
        ),
      );
    },
  );

  Widget get _allExercisesFetched => ListView.builder(
    itemCount: _allExercises.length,
    itemBuilder: (_, index) {
      final workout = _allExercises[index];
      final workoutValue = workout.value as WorkoutHealthValue;

      return Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Exercise #${index + 1}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Exercise Name: ${workoutValue.workoutActivityType.name}'),
              Text('Start Time: ${workout.dateFrom}'),
              Text('End Time: ${workout.dateTo}'),
              Text('Calories Burned: ${workoutValue.totalEnergyBurned?.toStringAsFixed(1) ?? "N/A"} kcal'),
              Text('Distance: ${workoutValue.totalDistance?.toStringAsFixed(1) ?? "N/A"} ${workoutValue.totalDistanceUnit?.name ?? ""}'),
              Text('Recording Method: ${workout.recordingMethod.name}'),
              Text('Title: ${workoutValue.workoutActivityType.name}'),
            ],
          ),
        ),
      );
    },
  );

  final Widget _dataNotAdded =
  const Text('Failed to add data.\nDo you have permissions to add data?');

  final Widget _dataNotDeleted = const Text('Failed to delete data');

  Widget get _content => switch (_state) {
    AppState.DATA_READY => _contentDataReady,
    AppState.DATA_NOT_FETCHED => _contentNotFetched,
    AppState.FETCHING_DATA => _contentFetchingData,
    AppState.NO_DATA => _contentNoData,
    AppState.AUTHORIZED => _authorized,
    AppState.AUTH_NOT_GRANTED => _authorizationNotGranted,
    AppState.DATA_ADDED => _dataAdded,
    AppState.DATA_DELETED => _dataDeleted,
    AppState.DATA_NOT_ADDED => _dataNotAdded,
    AppState.DATA_NOT_DELETED => _dataNotDeleted,
    AppState.STEPS_READY => _stepsFetched,
    AppState.HEALTH_CONNECT_STATUS => _contentHealthConnectStatus,
    AppState.PERMISSIONS_REVOKING => _permissionsRevoking,
    AppState.PERMISSIONS_REVOKED => _permissionsRevoked,
    AppState.PERMISSIONS_NOT_REVOKED => _permissionsNotRevoked,
    AppState.CALORIES_READY => _caloriesFetched,
    AppState.HEART_RATE_READY => _heartRateFetched,
    AppState.LAST_THREE_MINUTES_READY => _lastThreeMinutesFetched,
    AppState.ELLIPTICAL_WORKOUT_READY => _ellipticalWorkoutFetched,
    AppState.GYMNASTICS_WORKOUT_READY => _gymnasticsWorkoutFetched,
    AppState.ALL_EXERCISES_READY => _allExercisesFetched,
  };
}

