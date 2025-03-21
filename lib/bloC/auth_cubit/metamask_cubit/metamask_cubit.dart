import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';
import 'package:gymmerator/models/api_response/GetRewardSignatureApiResponse.dart';
import 'package:gymmerator/models/api_response/VerifySignatureApiResponse.dart';

import '../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../resources/repository.dart';

part 'metamask_state.dart';

class MetamaskCubit extends Cubit<MetamaskState> {
  MetamaskCubit() : super(MetamaskInitial());

  final _repository = Repository();

  Future featuredRequest() async {
    emit(LoadingState());
    final GetAllFavoriteProductApiResponse model =
        await _repository.getFavoriteProductRequest();
    if (model.error == null) {
      emit(AllFavoriteProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }

  Future getNonceRequest() async {
    emit(LoadingState());

    final GetNonceApiResponse model = await _repository.getNonceRequest();
    if (model.error == null) {
      emit(NonceGetSuccessfully(model));
    } else {
      emit(FailedToGetNonce(model.message ?? "Failed To Get Nonce"));
    }
  }

  Future verifyRequest({
    required int nonce,
    required String address,
    required String signature,
  }) async {
    emit(LoadingState());

    Map data = {
      "address": address,
      "signature": signature,
      "message": "This message verifies your wallet: $nonce",
      "nonce": nonce
    };
    final VerifySignatureApiResponse model =
        await _repository.verifySignatureRequest(data);
    if (model.error == null) {
      emit(VerifySignatureSuccessfully(model));
    } else {
      emit(FailedToVerifySignature(model));
    }
  }

  Future getSignatureRequest() async {
    emit(LoadingState());

    final GetRewardSignatureApiResponse model =
        await _repository.getSignatureRequest();
    if (model.error == null) {
      emit(GetSignatureRewardSuccessfully(model));
    } else {
      emit(FailedToGetSignature(model));
    }
  }
}
