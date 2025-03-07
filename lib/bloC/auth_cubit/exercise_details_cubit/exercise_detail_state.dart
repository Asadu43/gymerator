part of 'exercise_detail_cubit.dart';

sealed class ExerciseDetailState extends Equatable {
  const ExerciseDetailState();

  @override
  List<Object> get props => [];
}

final class ExerciseDetailInitial extends ExerciseDetailState {}

class LoadingState extends ExerciseDetailState {}

class AddMetricsSuccessfully extends ExerciseDetailState {
  final AddWorkoutMetricsApiResponse response;

  const AddMetricsSuccessfully(this.response);
}

class FailedToAddMetrics extends ExerciseDetailState {
  final AddWorkoutMetricsApiResponse response;

  const FailedToAddMetrics(this.response);
}
