import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/CreateOrderApiResponse.dart';

import '../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../resources/repository.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  final _repository = Repository();

  Future createRequest({
    required String shippingAddress,
    required String paymentAddress,
    required String paymentMethod,
    required String paymentIntentId,
    required int amount,
    required String currency,
  }) async {
    emit(LoadingState());

    Map data = {
      "shippingAddress": shippingAddress,
      "paymentAddress": paymentAddress,
      "paymentMethod": paymentMethod,
      //Possible methods =  "Card", "Cash on Delivery", "Gymerator Token"
      "paymentIntentId": paymentIntentId,
      "amount": amount,
      // Paid by cusotmer
      "currency": currency
    };

    print("\n\n\n\n");
    print(data);
    print("\n\n\n\n");
    final CreateOrderApiResponse model = await _repository.createRequest(data);
    if (model.error == null) {
      emit(CreateOrderSuccessfully(model));
    } else {
      emit(FailedToOrderCreate(model));
    }
  }

  Future featuredRequest() async {
    emit(LoadingState());
    final GetAllFavoriteProductApiResponse model =
        await _repository.getFavoriteProductRequest();
    if (model.error == null) {
      emit(AllFavoriteProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }
}
