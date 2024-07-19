import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'package:gymmerator/models/product_model.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/popular_products_screen/popular_product_item_card.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/product_item_card.dart';

import '../../../../../models/api_response/FeaturedProductApiResponse.dart';
import '../../../../../ui_component/show_snackbar.dart';

class PopularProductsScreen extends StatefulWidget {
  const PopularProductsScreen({super.key});

  @override
  State<PopularProductsScreen> createState() => _PopularProductsScreenState();
}

class _PopularProductsScreenState extends State<PopularProductsScreen> {
  FeaturedProductApiResponse? response;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedProductCubit()..featuredRequest(),
      child: BlocConsumer<FeaturedProductCubit, FeaturedProductState>(
        listener: (context, state) {
          if (state is FailedToGetProduct) {
            showSnackBar(context, response?.message ?? "Failed To Get Product");
          }
          if (state is FeaturedProductGetSuccessfully) {
            response = state.response;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: const Text('Popular Products',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
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
                        fieldTextStyle: GoogleFonts.vazirmatn(
                            color: Colors.black),
                      )),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: GridView.builder(
                      itemCount: response?.data?.hotProducts?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ProductItemCard(
                          product: response!.data!.hotProducts![index],
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          );
        },
      ),
    );
  }
}

