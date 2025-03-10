part of 'all_workout_metrics_cubit.dart';

sealed class AllWorkoutMetricsState extends Equatable {
  const AllWorkoutMetricsState();

  @override
  List<Object> get props => [];
}

final class AllWorkoutMetricsInitial extends AllWorkoutMetricsState {}

class LoadingState extends AllWorkoutMetricsState {}

class AllWorkoutMetricsSuccessfully extends AllWorkoutMetricsState {
  final GetWorkoutMetricsApiResponse response;

  const AllWorkoutMetricsSuccessfully(this.response);
}

class FailedToGetWorkoutMetrics extends AllWorkoutMetricsState {
  final GetWorkoutMetricsApiResponse response;

  const FailedToGetWorkoutMetrics(this.response);
}

class AllWorkoutMetricsByDateSuccessfully extends AllWorkoutMetricsState {
  final GetWorkoutMetricsByDateApiResponse response;

  const AllWorkoutMetricsByDateSuccessfully(this.response);
}

class FailedToGetWorkoutAllMetricsByDate extends AllWorkoutMetricsState {
  final GetWorkoutMetricsByDateApiResponse response;

  const FailedToGetWorkoutAllMetricsByDate(this.response);
}
