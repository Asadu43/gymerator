import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'package:gymmerator/models/api_response/FeaturedProductApiResponse.dart';
import 'package:gymmerator/models/product_model.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/featured_products_screen/featured_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/popular_products_screen/popular_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/product_details_screen/product_details_screen.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/product_item_card.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

import 'hot_product_item_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FeaturedProductApiResponse? response;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedProductCubit()..featuredRequest(),
      child: BlocConsumer<FeaturedProductCubit, FeaturedProductState>(
        listener: (context, state) {
          if(state is FailedToGetProduct){
            showSnackBar(context, "");
          }if (state is FeaturedProductGetSuccessfully){
            response = state.response;
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              drawer: const AppDrawer(),
              appBar: AppBar(
                title: const Text('Hi, Noah!'),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                            itemCount: response?.data?.featuredProducts?.length ?? 0,
                            itemExtent: MediaQuery.of(context).size.width * 0.4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ProductItemCard(
                                product: response!.data!.featuredProducts![index],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                            itemCount: response?.data?.hotProducts?.length ?? 0,
                            itemExtent: MediaQuery.of(context).size.width * 0.4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: HotProductItemCard(
                                  product: response!.data!.hotProducts![index],
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
      ),
    );
  }
}

List<Product> featuredProducts = [
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    price: 290.9,
    description:
        'This is the description of Product 1 lasdkfjk aljksdfl lljlkj asdfljk lkjasdf lk',
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
];

List<Product> popularProducts = [
  Product(
    imageUrl: 'assets/images/product3.png',
    name: 'Product 3',
    description: 'This is the description of Product 3',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product4.png',
    name: 'Product 4',
    description: 'This is the description of Product 4',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product5.png',
    name: 'Product 5',
    description: 'This is the description of Product 5',
    price: 290.9,
    like: true,
  ),
];
