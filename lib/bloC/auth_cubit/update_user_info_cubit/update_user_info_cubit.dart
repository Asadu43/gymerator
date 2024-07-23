import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/UpdateUserInfoApiResponse.dart';

import '../../../resources/repository.dart';

part 'update_user_info_state.dart';

class UpdateUserInfoCubit extends Cubit<UpdateUserInfoState> {
  UpdateUserInfoCubit() : super(UpdateUserInfoInitial());

  final _repository = Repository();

  Future updateInfoRequest({
    required String gender,
    required String heightUnit,
    required double heightValue,
    required String weightUnit,
    required double weightValue,
    required int age,
    required int goal,
    required int workoutLevel,
  }) async {
    emit(LoadingState());

    Map data = {
      "gender": gender, // Male, Female, Prefer Not to Say
      "heightUnit": heightUnit, // cm, Ft-in
      "heightValue": heightValue,
      "weightUnit": weightUnit, // Kg, lb
      "weightValue": weightValue,
      "age": age,
      "goal":
          goal, // 0 = LOSE_WEIGHT, 1 = KEEP_FIT, 2 = GET_STRONGER, 3 = MUSCLE_GAIN_MASS
      "workoutLevel":
          workoutLevel // 0 = Beginner, 1 = Intermediate, 2 = Advance
    };

    print("Data \n\n\ ${data} \n\n\n");

    final UpdateUserInfoApiResponse model =
        await _repository.updateUserInfoRequest(data);
    if (model.error == null) {
      emit(UpdateUserSuccessfully(model.message ?? "Update User Successfully"));
    } else {
      emit(FailedToUpdateUserInfo(model.message ?? "Failed To User Info."));
    }
  }
}
