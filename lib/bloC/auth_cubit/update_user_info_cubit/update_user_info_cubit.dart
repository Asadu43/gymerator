import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/UpdateUserInfoApiResponse.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

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
    required int sleepHours,
    required int mealFrequency,
    required int hydrationDaily,
    required int targetWeight,
    required int dietPlan,
    required String selectMedicalName,
    required String medicalCondition,
  }) async {
    emit(LoadingState());

    FormData formData = FormData.fromMap({
      "gender": gender,
      // Male, Female, Prefer Not to Say
      "heightUnit": heightUnit,
      // cm, Ft-in
      "heightValue": heightValue,
      "weightUnit": weightUnit,
      // Kg, lb
      "weightValue": weightValue,
      "age": age,
      "goal": goal,
      // 0 = LOSE_WEIGHT, 1 = KEEP_FIT, 2 = GET_STRONGER, 3 = MUSCLE_GAIN_MASS
      "workoutLevel": workoutLevel,
      // 0 = Beginner, 1 = Intermediate, 2 = Advance
      "sleepHours": sleepHours,
      "dietType": dietPlan,
      "mealFrequency": mealFrequency,
      "hydrationLitersPerDay": hydrationDaily,
      "targetWeightInKG": targetWeight,
      "medicalConditionName": selectMedicalName,
      "medicalCondition": medicalCondition
    });

    print("Data \n\n\ ${formData.fields} \n\n\n");

    final UpdateUserInfoApiResponse model =
        await _repository.updateUserInfoRequest(formData);
    if (model.error == null) {
      emit(UpdateUserSuccessfully(model.message ?? "Update User Successfully"));
    } else {
      emit(FailedToUpdateUserInfo(model.message ?? "Failed To User Info."));
    }
  }

  Future editProfileRequest({
    required String heightUnit,
    required double heightValue,
    required String weightUnit,
    required double weightValue,
    required int age,
    required String goal,
  }) async {
    emit(LoadingState());

    FormData data = FormData();
    if (goal == "Lose Weight") {
      data = FormData.fromMap({
        "heightUnit": heightUnit,
        "heightValue": heightValue,
        "weightUnit": weightUnit,
        "weightValue": weightValue,
        "age": age,
        "goal": 0
      });
    }
    if (goal == "Keep Fit") {
      data = FormData.fromMap({
        "heightUnit": heightUnit,
        // cm, Ft-in
        "heightValue": heightValue,
        "weightUnit": weightUnit,
        // Kg, lb
        "weightValue": weightValue.toDouble(),
        "age": age,
        "goal": 1,
        // 0 = LOSE_WEIGHT, 1 = KEEP_FIT, 2 = GET_STRONGER, 3 = MUSCLE_GAIN_MASS
      });
    }
    if (goal == "Get Stronger") {
      data = FormData.fromMap({
        "heightUnit": heightUnit,
        "heightValue": heightValue,
        "weightUnit": weightUnit,
        "weightValue": weightValue,
        "age": age,
        "goal": 2
      });
    }
    if (goal == "Gain Muscle Mass") {
      data = FormData.fromMap({
        "heightUnit": heightUnit,
        "heightValue": heightValue,
        "weightUnit": weightUnit,
        "weightValue": weightValue,
        "age": age,
        "goal": 3
      });
    }

    print("Data \n\n\ ${data} \n\n\n");

    final UpdateUserInfoApiResponse model =
        await _repository.updateUserInfoRequest(data);

    print("Data ${model.data}");
    print("Message ${model.message}");
    print("Error ${model.error}");
    if (model.error == null) {
      emit(UpdateUserSuccessfully(model.message ?? "Update User Successfully"));
    } else {
      emit(FailedToUpdateUserInfo(model.message ?? "Failed To User Info."));
    }
  }

  Future editAccountRequest({
    required String firstName,
    required String lastName,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String country,
    XFile? profileImage,
  }) async {
    emit(LoadingState());

    print(profileImage);
    FormData? formData;
    if (profileImage != null) {
      formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": country,
        "profile": await MultipartFile.fromFile(profileImage.path,
            contentType: MediaType("image", "jpeg"))
      });
    } else {
      formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": country
      });
    }

    print(formData.fields);

    final UpdateUserInfoApiResponse model =
        await _repository.updateUserInfoRequest(formData);
    if (model.error == null) {
      emit(UpdateUserSuccessfully(model.message ?? "Update User Successfully"));
    } else {
      emit(FailedToUpdateUserInfo(model.message ?? "Failed To User Info."));
    }
  }

// Future updateUserProfile({
//   required XFile profileImage,
// }) async {
//
//
//    String fileName = path.basename(profileImage.path);
//    print(profileImage.path);
//    print(fileName);
//   // print(await MultipartFile.fromFile(
//   //   profileImage.path,
//   // ));
//   // print(profileImage.path);
//   // final formData = FormData.fromMap({
//   //   'profile': await MultipartFile.fromFile(
//   //     profileImage.path,
//   //   ),
//   // });
//
//   Map data = {
//     "profile": fileName,
//   };
//
//   print("Profile Image \n\n ${data} \n\n\n");
//
//   final GetAllFavoriteProductApiResponse model =
//   await _repository.updateUserProfile(data);
//   if (model.error == null) {
//     emit(UpdateUserSuccessfully(model.message ?? "Update User Successfully"));
//   } else {
//     emit(FailedToUpdateUserInfo(model.message ?? "Failed To Update User Info."));
//   }
// }
}
