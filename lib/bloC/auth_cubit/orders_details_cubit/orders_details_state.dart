part of 'orders_details_cubit.dart';

abstract class OrdersDetailsState extends Equatable {
  const OrdersDetailsState();

  @override
  List<Object> get props => [];
}

class OrdersDetailsInitial extends OrdersDetailsState {}

class LoadingState extends OrdersDetailsState {}

class OrdersDetailGetSuccessfully extends OrdersDetailsState {
  final UserOrderDetailsApiResponse response;

  const OrdersDetailGetSuccessfully(this.response);
}

class FailedToGetOrdersDetail extends OrdersDetailsState {
  final UserOrderDetailsApiResponse response;

  const FailedToGetOrdersDetail(this.response);
}
