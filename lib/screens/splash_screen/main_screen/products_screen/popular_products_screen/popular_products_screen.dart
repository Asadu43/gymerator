import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../../models/api_response/FeaturedProductApiResponse.dart';
import '../../../../../ui_component/show_snackbar.dart';
import '../product_item_card.dart';

class PopularProductsScreen extends StatefulWidget {
  const PopularProductsScreen({super.key});

  @override
  State<PopularProductsScreen> createState() => _PopularProductsScreenState();
}

class _PopularProductsScreenState extends State<PopularProductsScreen> {
  FeaturedProductApiResponse? response;

  @override
  void initState() {
    context.read<FeaturedProductCubit>().featuredRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedProductCubit, FeaturedProductState>(
      listener: (context, state) {
        if (state is FailedToGetProduct) {
          showSnackBar(context, response?.message ?? "Failed To Get Product");
        }
        if (state is FeaturedProductGetSuccessfully) {
          response = state.response;
        }
        if (state is FailedToRemoveProduct) {
          showSnackBar(context,
              state.response.message ?? "Failed To Remove Favorite Product");
        }
        if (state is RemoveFavoriteProductGetSuccessfully) {
          showSnackBar(context,
              state.response.message ?? "Remove Favorite Product Successfully",
              type: SnackBarType.success);
          context.read<FeaturedProductCubit>().featuredRequest();
        }
        if (state is FailedAddToFavoriteProduct) {}
        if (state is AddToFavoriteSuccessfully) {
          showSnackBar(context,
              state.response.message ?? "Add Favorite Product Successfully",
              type: SnackBarType.success);
          context.read<FeaturedProductCubit>().featuredRequest();
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Scaffold(
            appBar: AppBar(
                title: const Text('Popular Products',
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
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppTextField(
                        hintText: 'Search products',
                        icon: const Icon(Icons.search),
                        color: Colors.grey,
                        prefixIconColor: Colors.grey,
                        fieldTextStyle:
                            GoogleFonts.vazirmatn(color: Colors.black),
                      )),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      itemCount:
                          response?.data?.updatedHotProducts?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductItemCard(
                          product: response!.data!.updatedHotProducts![index],
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
    );
  }
}
