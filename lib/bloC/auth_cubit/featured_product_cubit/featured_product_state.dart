part of 'featured_product_cubit.dart';

sealed class FeaturedProductState extends Equatable {
  const FeaturedProductState();
}

final class FeaturedProductInitial extends FeaturedProductState {
  @override
  List<Object> get props => [];
}
