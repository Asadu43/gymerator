import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/product_detail_cubit/product_detail_cubit.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/my_cart_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

import '../../../../../bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart'
    hide
        LoadingState,
        AddToFavoriteSuccessfully,
        FailedToRemoveProduct,
        RemoveFavoriteProductGetSuccessfully;
import '../../../../../models/api_response/GetAllUserProductApiResponse.dart';
import '../../../../../utils/api_constants/api_constants.dart';
import '../../../../../utils/nav/nav.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  int _selectedIndex = -1; // Initialize with -1 to indicate no selection

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  ProductDetailApiResponse? response;
  GetAllUserProductApiResponse? cartResponse;

  Future<void> backScreen(BuildContext context) async {
    // context.read<FeaturedProductCubit>().featuredRequest();
    Nav.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailCubit()
        ..detailRequest(id: widget.id)
        ..cartRequest(),
      child: BlocConsumer<ProductDetailCubit, ProductDetailState>(
        listener: (context, state) {
          if (state is FailedToGetProductDetail) {
            showSnackBar(context, state.response.message!);
          }
          if (state is ProductDetailGetSuccessfully) {
            response = state.response;
          }
          if (state is FailedAddToCartProduct) {
            showSnackBar(
                context, state.response.message ?? "Failed Add To Cart");
          }
          if (state is AddToCartSuccessfully) {
            context.read<ProductDetailCubit>().cartRequest();
            showSnackBar(
                context, state.response.message ?? "Add To Cart Successfully",
                type: SnackBarType.success);
          }
          if (state is FailedAddToCartProduct) {
            showSnackBar(context,
                state.response.message ?? "Failed To Add Favorite Product");
          }
          if (state is AddToFavoriteSuccessfully) {
            showSnackBar(context,
                state.response.message ?? "Add Favorite Product Successfully",
                type: SnackBarType.success);
            context.read<FeaturedProductCubit>().featuredRequest();
            context.read<ProductDetailCubit>().detailRequest(id: widget.id);
          }
          if (state is FailedToRemoveProduct) {
            showSnackBar(context,
                state.response.message ?? "Failed To Remove Favorite Product");
          }
          if (state is RemoveFavoriteProductGetSuccessfully) {
            showSnackBar(
                context,
                state.response.message ??
                    "Remove Favorite Product Successfully",
                type: SnackBarType.success);
            context.read<FeaturedProductCubit>().featuredRequest();
            context.read<ProductDetailCubit>().detailRequest(id: widget.id);
          }

          if (state is CartProductGetSuccessfully) {
            cartResponse = state.response;
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: (state is LoadingState)
                      ? const SizedBox()
                      : ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios),
                                  onPressed: () async {
                                    backScreen(context);
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Nav.pushReplace(
                                        context, const MyCartScreen());
                                  },
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          "assets/icons/cart_background.png"),
                                      (cartResponse?.data == null ||
                                              cartResponse
                                                      ?.data?.items?.isEmpty ==
                                                  true)
                                          ? const SizedBox()
                                          : Positioned(
                                              right: 1.w,
                                              top: 1.h,
                                              child: Container(
                                                width: 18.w,
                                                height: 18.h,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff3F710D),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Center(
                                                  child: Text(
                                                    cartResponse!
                                                        .data!.items!.length
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.vazirmatn(
                                                      color: Colors.white,
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            (response?.data?.images != null)
                                ? Center(
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: 250.h,
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.9,
                                        aspectRatio: 2.0,
                                      ),
                                      items: response?.data?.images?.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return SizedBox(
                                                width: 1.sw,
                                                // decoration: const BoxDecoration(
                                                //     color: Colors.amber
                                                // ),
                                                child: Image.network(
                                                  "${ApiConstants.baseUrl}/product/image/$i",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Center(
                                                      child: Text(
                                                        'Please Wait',
                                                        style: GoogleFonts
                                                            .vazirmatn(),
                                                      ),
                                                    );
                                                  },
                                                ));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    response?.data?.name ?? "",
                                    maxLines: 3,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                (response?.data?.isFavorite == false)
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<ProductDetailCubit>()
                                                  .addToFavoriteRequest(
                                                      id: response!.data!.id!);
                                            },
                                            child: const Icon(
                                                Icons.favorite_border)),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: InkWell(
                                            onTap: () {
                                              context
                                                  .read<ProductDetailCubit>()
                                                  .removeRequest(
                                                      id: response!.data!.id!);
                                            },
                                            child: const Icon(Icons.favorite,
                                                color: Colors.red)),
                                      )
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price',
                                      style: GoogleFonts.vazirmatn(
                                          fontSize: 11.sp, color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\$ ${((response?.data?.price ?? 1) * _quantity)}',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 20.w),
                                        (response?.data?.discount?.valid ==
                                                true)
                                            ? Text(
                                                '${((response?.data?.discount?.percentage))}%',
                                                style: GoogleFonts.vazirmatn(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 12.sp,
                                                    color: Colors.grey),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                                (response?.data?.isAvailable == true)
                                    ? Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: _decrementQuantity,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                ),
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              '$_quantity',
                                              style: GoogleFonts.vazirmatn(
                                                  fontSize: 12.sp),
                                            ),
                                            SizedBox(width: 8.w),
                                            InkWell(
                                              onTap: _incrementQuantity,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.r),
                                                ),
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Text(
                                        'Out of stock',
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 8.sp, color: Colors.red),
                                      ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Product Variants',
                              style: GoogleFonts.vazirmatn(fontSize: 13.sp),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              height: 50.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: response?.data?.variants?.length ??
                                    0, // Replace with actual data source
                                itemBuilder: (context, index) {
                                  bool isSelected = _selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xff3F710D)
                                                  : Colors.black),
                                          color: isSelected
                                              ? const Color(0xff3F710D)
                                              : Colors
                                                  .white, // Change color based on selection
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.05.sw),
                                            child: Text(
                                              response?.data?.variants?[index]
                                                      .variant ??
                                                  "", // Replace with actual text
                                              style: GoogleFonts.vazirmatn(
                                                fontSize: 12.sp,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Colors
                                                        .black, // Change text color based on selection
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Description',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              response?.data?.description ?? "",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 10.sp, color: Colors.grey),
                            ),
                            SizedBox(height: 50.h),
                            (response?.data?.isAvailable == true)
                                ? AppButton(
                                    text: "Add to Cart",
                                    onPressed: () {
                                      _onButtonPressed(context);
                                    },
                                  )
                                : const SizedBox(),
                            SizedBox(height: 20.h),
                          ],
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onButtonPressed(BuildContext context) async {
    if (_selectedIndex == -1) {
      showSnackBar(context, "Please Select Variant");
    } else {
      context.read<ProductDetailCubit>().addToCartRequest(
          id: response!.data!.id!,
          quantity: _quantity,
          variants: response!.data!.variants![_selectedIndex].id!);
    }
  }
}
