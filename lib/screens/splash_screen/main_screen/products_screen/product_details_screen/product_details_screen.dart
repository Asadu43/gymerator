import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmerator/bloC/auth_cubit/product_detail_cubit/product_detail_cubit.dart';
import 'package:gymmerator/models/api_response/ProductDetailApiResponse.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';

import '../../../../../bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart'
    hide
        LoadingState,
        AddToFavoriteSuccessfully,
        FailedToRemoveProduct,
        RemoveFavoriteProductGetSuccessfully;
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

  Future<void> backScreen(BuildContext context) async {
    // context.read<FeaturedProductCubit>().featuredRequest();
    Nav.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ProductDetailCubit()..detailRequest(id: widget.id),
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
                          // IconButton(
                          //   icon: const Icon(Icons.shopping_cart),
                          //   onPressed: () {
                          //     // Handle cart button press
                          //   },
                          // ),
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
                                              return const Center(
                                                child: Text('Please Wait'),
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
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
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
                              const Text(
                                'Price',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$ ${((response?.data?.price ?? 1) * _quantity)}',
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 20),
                                  (response?.data?.discount?.valid  == true ) ? Text(
                                    '${((response?.data?.discount?.percentage))}%',
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                        fontSize: 16,color: Colors.grey),
                                  ) :  const SizedBox(),

                                ],
                              ),
                            ],
                          ),
                          (response?.data?.isAvailable == true ) ? Row(
                            children: [
                              InkWell(
                                onTap: _decrementQuantity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
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
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: _incrementQuantity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ) : const Text(
                            'Out of stock',
                            style: TextStyle(
                                fontSize: 12 ,color: Colors.red),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            response?.data?.variants?.first.variant ?? "",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        response?.data?.description ?? "",
                      ),
                      const SizedBox(height: 50),
                      (response?.data?.isAvailable == true ) ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: screenWidth * 0.04,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.prductBuyNowButtonColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.prductBuyNowButtonColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () {
                              _onButtonPressed(context);
                            },
                            child: Container(
                              width: screenWidth * 0.6,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 5),
                                      blurRadius: 5.0)
                                ],
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // stops: const [0.0, 1.0],
                                  colors: [
                                    Color(0xffB14501),
                                    Color(0xff3F710D),
                                  ],
                                ),
                                // color: Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text("Add to Cart",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ) : const SizedBox(),

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
    context.read<ProductDetailCubit>().addToCartRequest(
        id: response!.data!.id!,
        quantity: _quantity,
        variants: response!.data!.variants!.first.id!);
  }
}
