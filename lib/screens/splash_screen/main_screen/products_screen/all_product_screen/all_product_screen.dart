import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetAllProductApiResponse.dart';
import 'package:gymmerator/models/api_response/SearchProductApiResponse.dart';

import '../../../../../bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import '../../../../../ui_component/app_textfield.dart';
import '../../../../../ui_component/loading_screen_animation.dart';
import '../../../../../ui_component/show_snackbar.dart';
import '../product_item_card.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  GetAllProductApiResponse? response;
  SearchProductApiResponse? searchResponse;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<FeaturedProductCubit>().getAllRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedProductCubit, FeaturedProductState>(
      listener: (context, state) {
        if (state is FailedToGetAllProduct) {
          showSnackBar(context, state.response);
        }
        if (state is GetAllProductSuccessfully) {
          response = state.response;
        }
        if (state is FailedToRemoveProduct) {}
        if (state is RemoveFavoriteProductGetSuccessfully) {
          context.read<FeaturedProductCubit>().featuredRequest();
          context.read<FeaturedProductCubit>().getAllRequest();
        }
        if (state is FailedAddToFavoriteProduct) {}
        if (state is AddToFavoriteSuccessfully) {
          context.read<FeaturedProductCubit>().featuredRequest();
          context.read<FeaturedProductCubit>().getAllRequest();
        }
        if (state is FailedToSearchProduct) {
          searchResponse = state.response;
        }
        if (state is SearchProductSuccessfully) {
          searchResponse = state.response;
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
                title: const Text('All Products',
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
                        controller: searchController,
                        hintText: 'Search products',
                        icon: const Icon(Icons.search),
                        color: Colors.grey,
                        onChanged: (p0) {
                          if (searchController.text.isNotEmpty) {
                            context
                                .read<FeaturedProductCubit>()
                                .searchRequest(id: searchController.text);
                          } else {
                            context
                                .read<FeaturedProductCubit>()
                                .getAllRequest();
                          }
                        },
                        prefixIconColor: Colors.grey,
                        fieldTextStyle:
                            GoogleFonts.vazirmatn(color: Colors.black),
                      )),
                  const SizedBox(height: 16.0),
                  (searchController.text.isNotEmpty &&
                          searchResponse?.data == null)
                      ? const Center(
                          child: Text("Product Not found"),
                        )
                      : (searchResponse != null)
                          ? Expanded(
                              child: GridView.builder(
                                itemCount: searchResponse?.data?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ProductItemCard(
                                    show: false,
                                    product: searchResponse!.data![index],
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
                            )
                          : Expanded(
                              child: GridView.builder(
                                itemCount: response?.data?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ProductItemCard(
                                    product: response!.data![index],
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
