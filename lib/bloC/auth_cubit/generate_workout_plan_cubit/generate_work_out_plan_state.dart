part of 'generate_work_out_plan_cubit.dart';

abstract class GenerateWorkOutPlanState extends Equatable {
  const GenerateWorkOutPlanState();

  @override
  List<Object> get props => [];
}

class GenerateWorkOutPlanInitial extends GenerateWorkOutPlanState {}

class LoadingState extends GenerateWorkOutPlanState {}

class GenerateWorkoutPlanSuccessfully extends GenerateWorkOutPlanState {
  final GenerateWorkoutPlanApiResponse response;
  const GenerateWorkoutPlanSuccessfully(this.response);
}

class FailedToGenerateWorkoutPlan extends GenerateWorkOutPlanState {
  final GenerateWorkoutPlanApiResponse response;

  const FailedToGenerateWorkoutPlan(this.response);
}

class AcceptWorkoutPlanSuccessfully extends GenerateWorkOutPlanState {
  final AcceptWorkoutPlanApiResponse response;
  const AcceptWorkoutPlanSuccessfully(this.response);
}

class FailedToAcceptWorkoutPlan extends GenerateWorkOutPlanState {
  final AcceptWorkoutPlanApiResponse response;

  const FailedToAcceptWorkoutPlan(this.response);
}
