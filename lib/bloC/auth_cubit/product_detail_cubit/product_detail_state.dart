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
