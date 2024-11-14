import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  style: GoogleFonts.vazirmatn(fontSize: 20.sp,fontWeight: FontWeight.w600),
                ),
              ),
              body: Padding(
                padding:  EdgeInsets.all(8.h),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                     SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(8.h),
                          child: Text(
                            'Featured',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp,fontWeight: FontWeight.w600),
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
                            padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 0.28.sh,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            response?.data?.updatedFeaturedProducts?.length ??
                                0,
                        itemExtent: 0.35.sw,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return FeaturedProductItemCard(
                            product:
                                response!.data!.updatedFeaturedProducts![index],
                          );
                        },
                      ),
                    ),
                    // SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                          child: Text(
                            'Most Popular',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
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
                            padding:EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      // Use SizedBox instead of Expanded
                      height: 0.32.sh, // Set a fixed height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            response?.data?.updatedHotProducts?.length ?? 0,
                        itemExtent: 0.45.sw,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.only(right: 8.w),
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
                          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                          child: Text(
                            'All Products',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.push(context, const AllProductScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.w),
                            child: Text(
                              'View All',
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp, color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 8.h),
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
                                padding:  EdgeInsets.only(right: 8.w),
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
