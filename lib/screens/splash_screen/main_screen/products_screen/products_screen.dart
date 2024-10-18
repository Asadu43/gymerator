import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';
import 'package:gymmerator/models/api_response/GetAllProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/featured_products_screen/featured_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/popular_products_screen/popular_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/product_item_card.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/featured_product_item_card.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

import '../../../../utils/nav/nav.dart';
import 'all_product_screen/all_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FeaturedProductApiResponse? response;
  GetAllProductApiResponse? allProduct;

  @override
  void initState() {
    context.read<FeaturedProductCubit>().featuredRequest();
    context.read<FeaturedProductCubit>().getAllRequest();
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
          context.read<FeaturedProductCubit>().getAllRequest();
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
          context.read<FeaturedProductCubit>().getAllRequest();
        }
        if (state is FailedToGetAllProduct) {
          showSnackBar(context, state.response);
        }
        if (state is GetAllProductSuccessfully) {
          allProduct = state.response;
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              drawer: const AppDrawer(),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Gymerator Store',
                  style: GoogleFonts.vazirmatn(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Featured Products',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FeaturedProductsScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: screenHeight * 0.28,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            response?.data?.updatedFeaturedProducts?.length ??
                                0,
                        itemExtent: MediaQuery.of(context).size.width * 0.3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FeaturedProductItemCard(
                            product:
                                response!.data!.updatedFeaturedProducts![index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Most Popular Products',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PopularProductsScreen()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      // Use SizedBox instead of Expanded
                      height: screenHeight * 0.32, // Set a fixed height
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'All Products',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.push(context, const AllProductScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    (allProduct == null)
                        ? const SizedBox()
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            // Allow scrolling
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 0.7,
                            ),
                            // itemCount: allProduct?.data?.length ?? 0,
                            itemCount: allProduct!.data!.length > 10
                                ? 10
                                : allProduct!.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ProductItemCard(
                                  product: allProduct!.data![index],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
