import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';

import '../../../resources/repository.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(ProductDetailInitial());

  final _repository = Repository();

  Future detailRequest({required String id}) async {
    emit(LoadingState());
    final ProductDetailApiResponse model =
        await _repository.getDetailProductRequest(id);
    if (model.error == null) {
      emit(ProductDetailGetSuccessfully(model));
    } else {
      emit(FailedToGetProductDetail(model));
    }
  }
}
