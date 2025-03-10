import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsApiResponse.dart';
import 'package:gymmerator/models/api_response/GetWorkoutMetricsByDateApiResponse.dart';

import '../../../resources/repository.dart';

part 'all_workout_metrics_state.dart';

class AllWorkoutMetricsCubit extends Cubit<AllWorkoutMetricsState> {
  AllWorkoutMetricsCubit() : super(AllWorkoutMetricsInitial());

  final _repository = Repository();

  Future allWorkoutMetricsRequest() async {
    emit(LoadingState());
    final GetWorkoutMetricsApiResponse model =
        await _repository.getWorkoutMetricRequest();
    if (model.error == null) {
      emit(AllWorkoutMetricsSuccessfully(model));
    } else {
      emit(FailedToGetWorkoutMetrics(model));
    }
  }

  Future getWorkoutByDateMetricsRequest({required String date}) async {
    emit(LoadingState());
    final GetWorkoutMetricsByDateApiResponse model =
        await _repository.getWorkoutByDateMetricsRequest(date);
    if (model.error == null) {
      emit(AllWorkoutMetricsByDateSuccessfully(model));
    } else {
      emit(FailedToGetWorkoutAllMetricsByDate(model));
    }
  }
}
