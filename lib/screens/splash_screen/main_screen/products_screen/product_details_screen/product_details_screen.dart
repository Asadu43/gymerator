import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/product_detail_cubit/product_detail_cubit.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/my_cart_screen.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
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
                              Nav.pushReplace(context, const MyCartScreen());
                            },
                            child: Stack(
                              children: <Widget>[
                                const IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: null,
                                ),
                                (cartResponse?.data == null ||
                                        cartResponse?.data?.items?.isEmpty ==
                                            true)
                                    ? const SizedBox()
                                    : Positioned(
                                        right: 5,
                                        top: 5,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xff3F710D),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              cartResponse!.data!.items!.length
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style:  GoogleFonts.vazirmatn(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500,
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
                                  height: 250.0,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.9,
                                  aspectRatio: 2.0,
                                ),
                                items: response?.data?.images?.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // decoration: const BoxDecoration(
                                          //     color: Colors.amber
                                          // ),
                                          child: Image.network(
                                            "${ApiConstants.baseUrl}/product/image/$i",
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return  Center(
                                                child: Text('Please Wait',style: GoogleFonts.vazirmatn(),),
                                              );
                                            },
                                          ));
                                    },
                                  );
                                }).toList(),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            response?.data?.name ?? "",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          (response?.data?.isFavorite == false)
                              ? InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductDetailCubit>()
                                        .addToFavoriteRequest(
                                            id: response!.data!.id!);
                                  },
                                  child: const Icon(Icons.favorite_border))
                              : InkWell(
                                  onTap: () {
                                    context
                                        .read<ProductDetailCubit>()
                                        .removeRequest(id: response!.data!.id!);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.vazirmatn(fontSize: 12.sp,color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$ ${((response?.data?.price ?? 1) * _quantity)}',
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 20),
                                  (response?.data?.discount?.valid == true)
                                      ? Text(
                                          '${((response?.data?.discount?.percentage))}%',
                                          style: GoogleFonts.vazirmatn(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 10.sp,
                                              color: Colors.grey),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                          (response?.data?.isAvailable == true)
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: _decrementQuantity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '$_quantity',
                                      style:
                                          GoogleFonts.vazirmatn(fontSize: 12.sp),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: _incrementQuantity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  'Out of stock',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 8.sp, color: Colors.red),
                                ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Product Variants',
                        style: GoogleFonts.vazirmatn(fontSize: 13.sp),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 50,
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
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                      padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: GoogleFonts.vazirmatn(
                                fontSize: 13.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        response?.data?.description ?? "",
                        style: GoogleFonts.vazirmatn(fontSize: 10.sp,color: Colors.grey),
                      ),
                      const SizedBox(height: 50),
                      (response?.data?.isAvailable == true)
                          ? AppButton(
                              text: "Add to Cart",
                              onPressed: () {
                                _onButtonPressed(context);
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
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
