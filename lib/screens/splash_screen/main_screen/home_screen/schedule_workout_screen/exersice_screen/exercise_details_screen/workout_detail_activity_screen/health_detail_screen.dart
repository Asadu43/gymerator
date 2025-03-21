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
}

class HealthAppState extends State<HealthApp> {
  final List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;
  final int _nofSteps = 0;
  final double _caloriesBurned = 0.0;
  double _latestHeartRate = 0.0;
  HealthDataPoint? _latestExercise;
  List<RecordingMethod> recordingMethodsToFilter = [];
  final health = Health();
  bool _isAuthorized = false;

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

    setState(() {
      _state = (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;
      _isAuthorized = authorized;
    });
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

        List<HealthDataPoint> heartRateData =
            await health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: yesterday,
          endTime: now,
        );

        if (heartRateData.isNotEmpty) {
          heartRateData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
          double latestHR = (heartRateData.first.value as NumericHealthValue)
              .numericValue
              .toDouble();

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
        final threeMinutesAgo = now.subtract(const Duration(hours: 3));

        // Fetch workout data
        List<HealthDataPoint> workoutData = await health.getHealthDataFromTypes(
          types: [HealthDataType.WORKOUT],
          startTime: threeMinutesAgo,
          endTime: now,
        );

        // Fetch heart rate data
        List<HealthDataPoint> heartRateData =
            await health.getHealthDataFromTypes(
          types: [HealthDataType.HEART_RATE],
          startTime: threeMinutesAgo,
          endTime: now,
        );

        setState(() {
          if (workoutData.isNotEmpty) {
            workoutData.sort((a, b) => b.dateTo.compareTo(a.dateTo));
            _latestExercise = workoutData.first;
          } else {
            _latestExercise = null;
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
        debugPrint("Exception in fetchLastThreeMinutesData: $error");
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
      if (success) {
        _isAuthorized = false;
      }
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
                    (Platform.isAndroid &&
                        health.healthConnectSdkStatus ==
                            HealthConnectSdkStatus.sdkAvailable))
                  Wrap(spacing: 10, children: [
                    if (!_isAuthorized)
                      TextButton(
                          onPressed: authorize,
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          child: const Text("Authenticate",
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
                    if (_isAuthorized)
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
            if (_state == AppState.STEPS_READY ||
                _state == AppState.LAST_THREE_MINUTES_READY)
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
                        if (_state == AppState.LAST_THREE_MINUTES_READY) {
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
    Text("Press 'Latest Heart Rate' to get recent heart rate."),
    Text(
        "Press 'Last 3 Min Data' to get latest exercise and heart rate in last 3 hours."),
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
          Text(
              'Calories Burned Today: ${_caloriesBurned.toStringAsFixed(1)} kcal'),
        ],
      );

  Widget get _caloriesFetched => Text(
      'Total Calories Burned (7 days): ${_caloriesBurned.toStringAsFixed(1)} kcal');

  Widget get _heartRateFetched =>
      Text('Latest Heart Rate: ${_latestHeartRate.toStringAsFixed(1)} bpm');

  Widget get _lastThreeMinutesFetched => Column(
        children: [
          Text('Latest Heart Rate: ${_latestHeartRate.toStringAsFixed(1)} bpm'),
          if (_latestExercise != null)
            Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Exercise (Last 3 Hours)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Type: ${(_latestExercise!.value as WorkoutHealthValue).workoutActivityType.name}'),
                    Text('Start Time: ${_latestExercise!.dateFrom}'),
                    Text('End Time: ${_latestExercise!.dateTo}'),
                    Text(
                        'Calories Burned: ${(_latestExercise!.value as WorkoutHealthValue).totalEnergyBurned?.toStringAsFixed(1) ?? "N/A"} kcal'),
                    Text(
                        'Distance: ${(_latestExercise!.value as WorkoutHealthValue).totalDistance?.toStringAsFixed(1) ?? "N/A"} ${(_latestExercise!.value as WorkoutHealthValue).totalDistanceUnit?.name ?? ""}'),
                    Text(
                        'Steps: ${(_latestExercise!.value as WorkoutHealthValue).totalSteps ?? "N/A"}'),
                    Text(
                        'Recording Method: ${_latestExercise!.recordingMethod.name}'),
                  ],
                ),
              ),
            )
          else
            const Text('No exercise data found in the last 3 hours'),
        ],
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
      };
}
