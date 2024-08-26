import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/featured_products_screen/featured_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/popular_products_screen/popular_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/product_item_card.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/featured_product_item_card.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FeaturedProductApiResponse? response;

  @override
  void initState() {
    context.read<FeaturedProductCubit>().featuredRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<FeaturedProductCubit, FeaturedProductState>(
      listener: (context, state) {
        if (state is FailedToGetProduct) {
          showSnackBar(context, "Failed To Get Products");
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
        if (state is FailedAddToFavoriteProduct) {
          showSnackBar(context,
              state.response.message ?? "Failed To Add Favorite Product");
        }
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
            drawer: const AppDrawer(),
            appBar: AppBar(
              title: const Text('Gymerator Store'),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Featured Products',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FeaturedProductsScreen()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'View All ',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        height: screenHeight * 0.3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              response?.data?.updatedFeaturedProducts?.length ??
                                  0,
                          itemExtent: MediaQuery.of(context).size.width * 0.3,

                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return FeaturedProductItemCard(
                              product: response!
                                  .data!.updatedFeaturedProducts![index],
                            );
                          },
                        ),
                      ),
                      // const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Most Popular Products',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PopularProductsScreen()));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              response?.data?.updatedHotProducts?.length ?? 0,
                          itemExtent: MediaQuery.of(context).size.width * 0.45,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ProductItemCard(
                                product:
                                    response!.data!.updatedHotProducts![index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
