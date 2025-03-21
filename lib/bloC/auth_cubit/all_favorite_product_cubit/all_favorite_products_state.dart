part of 'all_favorite_products_cubit.dart';

sealed class AllFavoriteProductsState extends Equatable {
  const AllFavoriteProductsState();

  @override
  List<Object> get props => [];
}

final class AllFavoriteProductsInitial extends AllFavoriteProductsState {}

class LoadingState extends AllFavoriteProductsState {}

class AllFavoriteProductGetSuccessfully extends AllFavoriteProductsState {
  final GetAllFavoriteProductApiResponse response;

  const AllFavoriteProductGetSuccessfully(this.response);
}

class FailedToGetProduct extends AllFavoriteProductsState {
  final GetAllFavoriteProductApiResponse response;

  const FailedToGetProduct(this.response);
}

class RemoveFavoriteProductGetSuccessfully extends AllFavoriteProductsState {
  final RemoveFavoriteProductApiResponse response;

  const RemoveFavoriteProductGetSuccessfully(this.response);
}

class FailedToRemoveProduct extends AllFavoriteProductsState {
  final RemoveFavoriteProductApiResponse response;

  const FailedToRemoveProduct(this.response);
}

class AllNotificationGetSuccessfully extends AllFavoriteProductsState {
  final GetNotificationsApiResponse response;

  const AllNotificationGetSuccessfully(this.response);
}

class FailedToGetNotifications extends AllFavoriteProductsState {
  final GetNotificationsApiResponse response;

  const FailedToGetNotifications(this.response);
}