import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/AddFavoriteProductApiResponse.dart';
import 'package:gymmerator/models/api_response/AddToCartProductApiResponse.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';

import '../../../models/api_response/GetAllUserProductApiResponse.dart';
import '../../../models/api_response/RemoveFavoriteProductApiResponse.dart';
import '../../../resources/repository.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());

  final _repository = Repository();

  Future detailRequest({required String id}) async {
    emit(LoadingState());
    final ProductDetailApiResponse model =
        await _repository.getDetailProductRequest(id);
    if (model.error == null) {
      emit(ProductDetailGetSuccessfully(model));
    } else {
      emit(FailedToGetProductDetail(model));
    }
  }

  Future addToCartRequest(
      {required String id,
      required int quantity,
      required String variants}) async {
    emit(LoadingState());
    Map data = {
      "productId": id,
      "quantity": quantity,
      "variants": [variants]
    };

    final AddToCartProductApiResponse model =
        await _repository.cartRequest(data);
    if (model.error == null) {
      emit(AddToCartSuccessfully(model));
    } else {
      emit(FailedAddToCartProduct(model));
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

  Future cartRequest() async {
    emit(LoadingState());
    final GetAllUserProductApiResponse model =
        await _repository.getCartProductRequest();
    if (model.error == null) {
      emit(CartProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }
}
