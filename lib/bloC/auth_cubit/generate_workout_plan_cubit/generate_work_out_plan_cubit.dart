import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/AcceptWorkoutPlanApiResponse.dart';
import 'package:gymmerator/models/api_response/GenerateWorkoutPlanApiResponse.dart';

import '../../../resources/repository.dart';

part 'generate_work_out_plan_state.dart';

class GenerateWorkOutPlanCubit extends Cubit<GenerateWorkOutPlanState> {
  GenerateWorkOutPlanCubit() : super(GenerateWorkOutPlanInitial());

  final _repository = Repository();

  Future generateWorkoutRequest() async {
    emit(LoadingState());
    final GenerateWorkoutPlanApiResponse model =
        await _repository.generateRequest();
    print("model.data \n\n\n");
    print(model.data?.length);
    if (model.error == null) {
      emit(GenerateWorkoutPlanSuccessfully(model));
    } else {
      emit(FailedToGenerateWorkoutPlan(model));
    }
  }

  Future acceptWorkoutRequest({required var exercisePlan}) async {
    emit(LoadingState());

    var data = {"workoutPlan": exercisePlan};

    print(data);

    final AcceptWorkoutPlanApiResponse model =
        await _repository.acceptWorkoutRequest(data);
    if (model.error == null) {
      emit(AcceptWorkoutPlanSuccessfully(model));
    } else {
      emit(FailedToAcceptWorkoutPlan(model));
    }
  }
}
