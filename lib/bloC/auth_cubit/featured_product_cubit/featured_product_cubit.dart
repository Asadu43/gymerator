import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'featured_product_state.dart';

class FeaturedProductCubit extends Cubit<FeaturedProductState> {
  FeaturedProductCubit() : super(FeaturedProductInitial());
}
