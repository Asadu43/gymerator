part of 'user_orders_cubit.dart';

abstract class UserOrdersState extends Equatable {
  const UserOrdersState();

  @override
  List<Object> get props => [];
}

class UserOrdersInitial extends UserOrdersState {}

class LoadingState extends UserOrdersState {}

class AllOrdersGetSuccessfully extends UserOrdersState {
  final GetAllUserOrdersApiResponse response;
  const AllOrdersGetSuccessfully(this.response);
}

class FailedToGetAllOrders extends UserOrdersState {
  final String response;
  const FailedToGetAllOrders(this.response);
}
