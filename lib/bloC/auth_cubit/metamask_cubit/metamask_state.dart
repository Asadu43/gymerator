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
