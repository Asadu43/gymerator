import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';

import '../../../models/api_response/AddFavoriteProductApiResponse.dart';
import '../../../models/api_response/RemoveFavoriteProductApiResponse.dart';
import '../../../resources/repository.dart';

part 'featured_product_state.dart';

class FeaturedProductCubit extends Cubit<FeaturedProductState> {
  FeaturedProductCubit() : super(FeaturedProductInitial());

  final _repository = Repository();

  Future featuredRequest() async {
    emit(LoadingState());
    final FeaturedProductApiResponse model =
        await _repository.getFeaturedProductRequest();

    print(model.message ?? "Hello");
    print(model.data ?? "Hello");
    if (model.error == null) {
      emit(FeaturedProductGetSuccessfully(model));
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

  Future addToFavoriteRequest({
    required String id,
  }) async {
    emit(LoadingState());
    final AddFavoriteProductApiResponse model =
    await _repository.addFavoriteProductRequest(id);
    if (model.error == null) {
      emit(AddToFavoriteSuccessfully(model));
    } else {
      emit(FailedAddToFavoriteProduct(model));
    }
  }
}
