part of 'product_detail_cubit.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

class LoadingState extends ProductDetailState {}

class ProductDetailGetSuccessfully extends ProductDetailState {
  final ProductDetailApiResponse response;

  const ProductDetailGetSuccessfully(this.response);
}

class FailedToGetProductDetail extends ProductDetailState {
  final ProductDetailApiResponse response;

  const FailedToGetProductDetail(this.response);
}

class AddToCartSuccessfully extends ProductDetailState {
  final AddToCartProductApiResponse response;

  const AddToCartSuccessfully(this.response);
}

class FailedAddToCartProduct extends ProductDetailState {
  final AddToCartProductApiResponse response;

  const FailedAddToCartProduct(this.response);
}

class AddToFavoriteSuccessfully extends ProductDetailState {
  final AddFavoriteProductApiResponse response;

  const AddToFavoriteSuccessfully(this.response);
}

class FailedAddToFavoriteProduct extends ProductDetailState {
  final AddFavoriteProductApiResponse response;

  const FailedAddToFavoriteProduct(this.response);
}
class RemoveFavoriteProductGetSuccessfully extends ProductDetailState {
  final RemoveFavoriteProductApiResponse response;

  const RemoveFavoriteProductGetSuccessfully(this.response);
}

class FailedToRemoveProduct extends ProductDetailState {
  final RemoveFavoriteProductApiResponse response;

  const FailedToRemoveProduct(this.response);
}