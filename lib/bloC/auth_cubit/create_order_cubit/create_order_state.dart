part of 'create_order_cubit.dart';

abstract class CreateOrderState extends Equatable {
  const CreateOrderState();

  @override
  List<Object> get props => [];
}

class CreateOrderInitial extends CreateOrderState {}

class LoadingState extends CreateOrderState {}

class CreateOrderSuccessfully extends CreateOrderState {
  final CreateOrderApiResponse response;

  const CreateOrderSuccessfully(this.response);
}

class FailedToOrderCreate extends CreateOrderState {
  final CreateOrderApiResponse response;

  const FailedToOrderCreate(this.response);
}

class AllFavoriteProductGetSuccessfully extends CreateOrderState {
  final GetAllFavoriteProductApiResponse response;

  const AllFavoriteProductGetSuccessfully(this.response);
}

class FailedToGetProduct extends CreateOrderState {
  final GetAllFavoriteProductApiResponse response;

  const FailedToGetProduct(this.response);
}
