import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';

import '../../../resources/repository.dart';

part 'featured_product_state.dart';

class FeaturedProductCubit extends Cubit<FeaturedProductState> {
  FeaturedProductCubit() : super(FeaturedProductInitial());

  final _repository = Repository();

  Future featuredRequest() async {
    emit(LoadingState());
    final FeaturedProductApiResponse model =
        await _repository.getFeaturedProductRequest();

    print(model.message ?? "Hello");
    print(model.error ?? "Hello");
    if (model.error == null) {
      emit(FeaturedProductGetSuccessfully(model));
    } else {
      emit(FailedToGetProduct(model));
    }
  }
}
