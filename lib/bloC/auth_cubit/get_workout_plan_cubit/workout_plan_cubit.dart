import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';

import '../../../resources/repository.dart';

part 'workout_plan_state.dart';

class WorkoutPlanCubit extends Cubit<WorkoutPlanState> {
  WorkoutPlanCubit() : super(WorkoutPlanInitial());

  final _repository = Repository();

  Future getWorkoutRequest() async {
    emit(LoadingState());
    final GetWorkoutPlanApiResponse model =
        await _repository.getWorkoutRequest();

    print(model.data?.workoutPlan?[0].day);

    if (model.error == null) {
      emit(GetWorkoutSuccessfully(model));
    } else {
      emit(FailedToGetWorkoutPlan(model));
    }
  }
}
