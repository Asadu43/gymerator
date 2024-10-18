import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/user_cart_product_cubit/user_cart_products_cubit.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/ItemQuantity.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/checkout_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../utils/api_constants/api_constants.dart';
import '../../../../utils/nav/nav.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  int count = 0;

  void increment() async {
    setState(() {
      count++;
    });
  }

  void decrement() async {
    setState(() {
      count--;
    });
  }

  GetAllUserProductApiResponse? response;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => UserCartProductsCubit()..cartRequest(),
      child: BlocConsumer<UserCartProductsCubit, UserCartProductsState>(
        listener: (context, state) {
          if (state is FailedToGetProduct) {
            // showSnackBar(context,
            //     state.response.message ?? "Failed To Get Cart Product");
          }
          if (state is CartProductGetSuccessfully) {
            response = state.response;
          }
          if (state is FailedToUpdateCartItem) {
            showSnackBar(context,
                state.response.message ?? "Failed To Update Cart Product");
          }
          if (state is CartItemUpdateSuccessfully) {
            showSnackBar(context,
                state.response.message ?? "Cart Item Updated Successfully",
                type: SnackBarType.success);
            context.read<UserCartProductsCubit>().cartRequest();
          }
          if (state is FailedToRemoveCartItem) {
            showSnackBar(context,
                state.response.message ?? "Failed To Remove Cart Product");
          }
          if (state is CartItemRemoveSuccessfully) {
            showSnackBar(context,
                state.response.message ?? "Cart Item Remove Successfully",
                type: SnackBarType.success);
            context.read<UserCartProductsCubit>().cartRequest();
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Nav.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                            SizedBox(width: screenWidth * 0.2),
                            Text("  My Cart",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? Center(
                                child: Text(
                                  "No Item in Cart",
                                  style: GoogleFonts.vazirmatn(),
                                ),
                              )
                            : ListView.builder(
                                itemCount: response?.data?.items?.length ?? 0,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      extentRatio: 0.4,
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (BuildContext context) {
                                            context
                                                .read<UserCartProductsCubit>()
                                                .removeRequest(
                                                    id: response!.data!
                                                        .items![index].id!);
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          icon: Icons.delete,
                                          label: 'delete',
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 16.0, right: 16.0),
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0, right: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: screenWidth * 0.2,
                                                // color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Image.network(
                                                    "${ApiConstants.baseUrl}/product/image/${response?.data?.items?[index].product?.images?.first}",
                                                    fit: BoxFit.fitHeight,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Text(
                                                          'Please Wait',
                                                          style: GoogleFonts
                                                              .vazirmatn(),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              SizedBox(
                                                width: screenWidth * 0.3,
                                                // color: Colors.red,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      response
                                                              ?.data
                                                              ?.items?[index]
                                                              .product
                                                              ?.name ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    ItemQuantity(
                                                        quantity: int.parse(
                                                            response!
                                                                .data!
                                                                .items![index]
                                                                .quantity
                                                                .toString()),
                                                        id: response!.data!
                                                            .items![index].id!)
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "\$ ${response?.data?.items?[index].total}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.vazirmatn(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? const SizedBox()
                            : Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Total Price Before Discount ",
                                        ),
                                        Text(
                                          "\$ ${response?.data?.subTotal}",
                                          style: GoogleFonts.vazirmatn(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Discount ",
                                          style: GoogleFonts.vazirmatn(),
                                        ),
                                        Text(
                                          "\$ ${response?.data?.discount?.toStringAsFixed(2)}",
                                          style: GoogleFonts.vazirmatn(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Total Price \$ ${response?.data?.total.toString()}",
                                      style: GoogleFonts.vazirmatn(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? const SizedBox()
                            : SizedBox(
                                height: screenHeight * 0.1,
                              ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? const SizedBox()
                            : AppButton(
                                text: "Checkout",
                                onPressed: () async {
                                  Nav.push(
                                      context,
                                      CheckoutScreen(
                                        totalAmount: response!.data!.subTotal!,
                                        totalDiscount:
                                            response!.data!.discount!,
                                        totalProducts:
                                            response!.data!.items!.length,
                                        totalPayingPrice:
                                            response!.data!.total!,
                                      ));
                                },
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
