import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/UserOrderDetailsApiResponse.dart';

import '../../../resources/repository.dart';

part 'orders_details_state.dart';

class OrdersDetailsCubit extends Cubit<OrdersDetailsState> {
  OrdersDetailsCubit() : super(OrdersDetailsInitial());

  final _repository = Repository();

  Future detailRequest({required String id}) async {
    emit(LoadingState());
    final UserOrderDetailsApiResponse model =
        await _repository.detailsRequest(id);
    if (model.error == null) {
      emit(OrdersDetailGetSuccessfully(model));
    } else {
      emit(FailedToGetOrdersDetail(model));
    }
  }
}
