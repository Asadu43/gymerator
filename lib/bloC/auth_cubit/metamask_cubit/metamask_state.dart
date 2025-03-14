part of 'metamask_cubit.dart';

sealed class MetamaskState extends Equatable {
  const MetamaskState();

  @override
  List<Object> get props => [];
}

final class MetamaskInitial extends MetamaskState {}

final class LoadingState extends MetamaskState {}

final class NonceGetSuccessfully extends MetamaskState {
  final GetNonceApiResponse? response;

  const NonceGetSuccessfully(this.response);
}

final class FailedToGetNonce extends MetamaskState {
  final String? response;

  const FailedToGetNonce(this.response);
}

final class VerifySignatureSuccessfully extends MetamaskState {
  final VerifySignatureApiResponse? response;

  const VerifySignatureSuccessfully(this.response);
}

final class FailedToVerifySignature extends MetamaskState {
  final String? response;

  const FailedToVerifySignature(this.response);
}

class AllFavoriteProductGetSuccessfully extends MetamaskState {
  final GetAllFavoriteProductApiResponse response;

  const AllFavoriteProductGetSuccessfully(this.response);
}

class FailedToGetProduct extends MetamaskState {
  final GetAllFavoriteProductApiResponse response;

  const FailedToGetProduct(this.response);
}


class GetSignatureRewardSuccessfully extends MetamaskState {
  final GetRewardSignatureApiResponse response;

  const GetSignatureRewardSuccessfully(this.response);
}

class FailedToGetSignature extends MetamaskState {
  final GetRewardSignatureApiResponse response;

  const FailedToGetSignature(this.response);
}