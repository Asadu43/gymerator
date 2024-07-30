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

class CartItemUpdateSuccessfully extends UserCartProductsState {
  final UpdateCartItemApiResponse response;

  const CartItemUpdateSuccessfully(this.response);
}

class FailedToUpdateCartItem extends UserCartProductsState {
  final UpdateCartItemApiResponse response;

  const FailedToUpdateCartItem(this.response);
}

class CartItemRemoveSuccessfully extends UserCartProductsState {
  final RemoveCartItemApiResponse response;

  const CartItemRemoveSuccessfully(this.response);
}

class FailedToRemoveCartItem extends UserCartProductsState {
  final RemoveCartItemApiResponse response;

  const FailedToRemoveCartItem(this.response);
}
