import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/RemoveFavoriteProductApiResponse.dart';

import '../../../resources/repository.dart';

part 'all_favorite_products_state.dart';

class AllFavoriteProductsCubit extends Cubit<AllFavoriteProductsState> {
  AllFavoriteProductsCubit() : super(AllFavoriteProductsInitial());

  final _repository = Repository();

  Future featuredRequest() async {
    emit(LoadingState());
    final GetAllFavoriteProductApiResponse model =
        await _repository.getFavoriteProductRequest();
    if (model.error == null) {
      storeToken(model.data!.isRequiredInfoAdded!);
      storeAccept(model.data!.isAccepted!);
      emit(AllFavoriteProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }

  Future removeRequest({required String id}) async {
    emit(LoadingState());
    final RemoveFavoriteProductApiResponse model =
        await _repository.removeFavoriteRequest(id);

    if (model.error == null) {
      emit(RemoveFavoriteProductGetSuccessfully(model));
    } else {
      emit(FailedToRemoveProduct(model));
    }
  }

  storeToken(bool result) {
    GetStorage().write('isRequiredInfoAdded', result);
  }

  storeAccept(bool result) {
    GetStorage().write('isAccepted', result);
  }
}
