import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';

import '../../../resources/repository.dart';

part 'user_cart_products_state.dart';

class UserCartProductsCubit extends Cubit<UserCartProductsState> {
  UserCartProductsCubit() : super(UserCartProductsInitial());

  final _repository = Repository();

  Future cartRequest() async {
    emit(LoadingState());
    final GetAllUserProductApiResponse model =
        await _repository.getCartProductRequest();

    print(model.message);
    print(model.error);
    print(model.data);
    if (model.error == null) {
      emit(CartProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }
}
