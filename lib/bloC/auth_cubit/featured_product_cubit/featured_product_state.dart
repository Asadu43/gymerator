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

class RemoveFavoriteProductGetSuccessfully extends FeaturedProductState {
  final RemoveFavoriteProductApiResponse response;

  const RemoveFavoriteProductGetSuccessfully(this.response);
}

class FailedToRemoveProduct extends FeaturedProductState {
  final RemoveFavoriteProductApiResponse response;

  const FailedToRemoveProduct(this.response);
}

class AddToFavoriteSuccessfully extends FeaturedProductState {
  final AddFavoriteProductApiResponse response;

  const AddToFavoriteSuccessfully(this.response);
}

class FailedAddToFavoriteProduct extends FeaturedProductState {
  final AddFavoriteProductApiResponse response;

  const FailedAddToFavoriteProduct(this.response);
}

class GetAllProductSuccessfully extends FeaturedProductState {
  final GetAllProductApiResponse response;

  const GetAllProductSuccessfully(this.response);
}

class FailedToGetAllProduct extends FeaturedProductState {
  final String response;

  const FailedToGetAllProduct(this.response);
}

class SearchProductSuccessfully extends FeaturedProductState {
  final SearchProductApiResponse response;

  const SearchProductSuccessfully(this.response);
}

class FailedToSearchProduct extends FeaturedProductState {
  final SearchProductApiResponse response;

  const FailedToSearchProduct(this.response);
}
