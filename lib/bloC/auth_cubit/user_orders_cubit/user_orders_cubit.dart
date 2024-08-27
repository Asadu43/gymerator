import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetAllUserOrdersApiResponse.dart';

import '../../../resources/repository.dart';

part 'user_orders_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  UserOrdersCubit() : super(UserOrdersInitial());

  final _repository = Repository();

  Future getAllOrdersRequest() async {
    emit(LoadingState());
    final GetAllUserOrdersApiResponse model =
        await _repository.getAllOrdersRequest();
    if (model.error == null) {
      emit(AllOrdersGetSuccessfully(model));
    } else {
      emit(FailedToGetAllOrders(model.message ?? "Failed To Get All Orders"));
    }
  }
}
