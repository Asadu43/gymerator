import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/GetNonceApiResponse.dart';

import '../../../resources/repository.dart';

part 'metamask_state.dart';

class MetamaskCubit extends Cubit<MetamaskState> {
  MetamaskCubit() : super(MetamaskInitial());

  final _repository = Repository();

  Future getNonceRequest() async {
    emit(LoadingState());

    final GetNonceApiResponse model = await _repository.getNonceRequest();
    if (model.error == null) {
      emit(NonceGetSuccessfully(model));
    } else {
      emit(FailedToGetNonce(model.message ?? "Failed To Get Nonce"));
    }
  }

  // Future verifyRequest({
  //   required int nonce,
  //   required String address,
  //   required String signature,
  // }) async {
  //   emit(LoadingState());
  //
  //   Map data = {
  //     "address": address,
  //     "signature":signature,
  //     "message": "This message is verified your wallet: $nonce",
  //     "nonce": nonce
  //   };
  //   final GetNonceApiResponse model = await _repository.verifyNonceRequest(data);
  //   if (model.error == null) {
  //     emit(NonceGetSuccessfully(model));
  //   } else {
  //     emit(FailedToGetNonce(model.message ?? "Failed To Get Nonce"));
  //   }
  // }
}
