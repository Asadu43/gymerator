import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/AddWorkoutMetricsApiResponse.dart';

import '../../../resources/repository.dart';

part 'exercise_detail_state.dart';

class ExerciseDetailCubit extends Cubit<ExerciseDetailState> {
  ExerciseDetailCubit() : super(ExerciseDetailInitial());

  final _repository = Repository();

  Future addWorkoutMetricsRequest({
    required String day,
    required String exerciseName,
    required int reps,
    required int sets,
    required int weightUsed,
    required int caloriesBurned,
    required int duration,
    required double heartRate,
    required int distance,
    required int pace,
  }) async {
    emit(LoadingState());
    Map data = {
      "day": day,
      "exercise": exerciseName,
      "repsCompleted": reps,
      "setsCompleted": sets,
      "weightUsed": weightUsed,
      "caloriesBurned": caloriesBurned,
      "durationMinutes": duration,
      "heartRateAvg": heartRate,
      "distanceCovered": distance,
      "pace": pace //  m/sec --> (meter/sec)
    };

    print(data);
    final AddWorkoutMetricsApiResponse model =
        await _repository.addWorkoutMetricRequest(data);
    if (model.error == null) {
      emit(AddMetricsSuccessfully(model));
    } else {
      emit(FailedToAddMetrics(model));
    }
  }
}
