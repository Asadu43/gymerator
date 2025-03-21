import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
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
                  centerTitle: true,
                  title: Text('Favorite Products',
                      style: GoogleFonts.vazirmatn(
                          fontSize: 20.sp, fontWeight: FontWeight.w600)),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h),
                    (response?.data?.favoriteProducts?.length == 0)
                        ? Center(
                            child: Text(
                            "No Item Found",
                            style: GoogleFonts.vazirmatn(),
                          ))
                        : Expanded(
                            child: GridView.builder(
                              itemCount:
                                  response?.data?.favoriteProducts?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return FavoriteProductItemCard(
                                  product:
                                      response!.data!.favoriteProducts![index],
                                );
                              },
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 0.7
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
