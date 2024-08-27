import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmerator/bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

import '../../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'favorite_product_item_card.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  GetAllFavoriteProductApiResponse? response;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFavoriteProductsCubit()..featuredRequest(),
      child: BlocConsumer<AllFavoriteProductsCubit, AllFavoriteProductsState>(
        listener: (context, state) {
          if (state is FailedToGetProduct) {
            showSnackBar(context, state.response.error);
          }
          if (state is AllFavoriteProductGetSuccessfully) {
            response = state.response;
          }
          if (state is FailedToRemoveProduct) {
            showSnackBar(context,
                state.response.message ?? "Failed To Remove Favorite Product");
          }
          if (state is RemoveFavoriteProductGetSuccessfully) {
            showSnackBar(context,
                state.response.message ?? "Remove Product Successfully",
                type: SnackBarType.success);
            context.read<AllFavoriteProductsCubit>().featuredRequest();
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              appBar: AppBar(
                  title: const Text('Favorite Products',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (response?.data?.favoriteProducts?.length == 0)
                        ? const SizedBox()
                        : const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AppTextField(
                              prefixIconColor: Colors.grey,
                              hintText: 'Search products',
                              icon: Icon(Icons.search),
                              color: Colors.grey,
                            )),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: GridView.builder(
                        itemCount:
                            response?.data?.favoriteProducts?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FavoriteProductItemCard(
                            product: response!.data!.favoriteProducts![index],
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
