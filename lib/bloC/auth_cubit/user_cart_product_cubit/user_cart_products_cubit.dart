import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';
import 'package:gymmerator/models/api_response/RemoveCartItemApiResponse.dart';
import 'package:gymmerator/models/api_response/UpdateCartItemApiResponse.dart';

import '../../../resources/repository.dart';

part 'user_cart_products_state.dart';

class UserCartProductsCubit extends Cubit<UserCartProductsState> {
  UserCartProductsCubit() : super(UserCartProductsInitial());

  final _repository = Repository();

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

  Future updateRequest({required String id, required int quantity}) async {
    emit(LoadingState());
    final UpdateCartItemApiResponse model =
        await _repository.updateItemRequest(id, quantity);
    if (model.error == null) {
      emit(CartItemUpdateSuccessfully(model));
    } else {
      emit(FailedToUpdateCartItem(model));
    }
  }

  Future removeRequest({required String id}) async {
    emit(LoadingState());
    final RemoveCartItemApiResponse model = await _repository.removeRequest(id);
    if (model.error == null) {
      emit(CartItemRemoveSuccessfully(model));
    } else {
      emit(FailedToRemoveCartItem(model));
    }
  }
}
