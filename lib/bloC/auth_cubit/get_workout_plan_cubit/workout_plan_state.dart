part of 'workout_plan_cubit.dart';

abstract class WorkoutPlanState extends Equatable {
  const WorkoutPlanState();

  @override
  List<Object> get props => [];
}

class WorkoutPlanInitial extends WorkoutPlanState {}

class LoadingState extends WorkoutPlanState {}

class GetWorkoutSuccessfully extends WorkoutPlanState {
  final GetWorkoutPlanApiResponse response;

  const GetWorkoutSuccessfully(this.response);
}

class FailedToGetWorkoutPlan extends WorkoutPlanState {
  final GetWorkoutPlanApiResponse response;

  const FailedToGetWorkoutPlan(this.response);
}
