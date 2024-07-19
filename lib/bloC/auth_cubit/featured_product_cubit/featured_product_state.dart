part of 'featured_product_cubit.dart';

sealed class FeaturedProductState extends Equatable {
  const FeaturedProductState();

  @override
  List<Object> get props => [];
}

final class FeaturedProductInitial extends FeaturedProductState {}

class LoadingState extends FeaturedProductState {}

class FeaturedProductGetSuccessfully extends FeaturedProductState {
  final FeaturedProductApiResponse? response;

  const FeaturedProductGetSuccessfully(this.response);
}

class FailedToGetProduct extends FeaturedProductState {
  final FeaturedProductApiResponse response;

  const FailedToGetProduct(this.response);
}
