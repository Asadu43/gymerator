part of 'user_cart_products_cubit.dart';

sealed class UserCartProductsState extends Equatable {
  const UserCartProductsState();

  @override
  List<Object> get props => [];
}

final class UserCartProductsInitial extends UserCartProductsState {}

class LoadingState extends UserCartProductsState {}

class CartProductGetSuccessfully extends UserCartProductsState {
  final GetAllUserProductApiResponse? response;

  const CartProductGetSuccessfully(this.response);
}

class FailedToGetProduct extends UserCartProductsState {
  final GetAllUserProductApiResponse response;

  const FailedToGetProduct(this.response);
}
