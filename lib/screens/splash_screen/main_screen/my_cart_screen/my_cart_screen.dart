import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            showSnackBar(context,
                state.response.message ?? "Failed To Get Cart Product");
          }
          if (state is CartProductGetSuccessfully) {
            response = state.response;
          }if (state is FailedToUpdateCartItem){
            showSnackBar(context,
                state.response.message ?? "Failed To Update Cart Product");
          }if(state is CartItemUpdateSuccessfully){
            showSnackBar(context,
                state.response.message ?? "Cart Item Update Successfully",type: SnackBarType.success);
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
                            Text("My Cart",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        
                        (response?.data?.items?.isEmpty == null) ? const Center(child: Text("No Item in Cart"),)
                            : 
                        ListView.builder(
                          itemCount: response?.data?.items?.length ?? 0,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                  left: 16.0, right: 16.0),
                              child: Container(
                                height: screenHeight * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.2,
                                        // color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.network(
                                            "${ApiConstants.baseUrl}/product/image/${response?.data?.items?[index].product?.images?.first}",
                                            fit: BoxFit.fitHeight,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Text('Please Wait'),
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
                                              response?.data?.items?[index]
                                                      .product?.name ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.vazirmatn(
                                                  color: Colors.black,
                                                  fontSize: 12,

                                                  fontWeight: FontWeight.bold),
                                            ),

                                            ItemQuantity(quantity: int.parse(response!.data!.items![index].quantity.toString()), id: response!.data!.items![index].id!)
                                            // Center(
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            //     children: [
                                            //       Container(
                                            //           height: screenHeight * 0.035,
                                            //           width: screenWidth * 0.08,
                                            //           decoration: BoxDecoration(
                                            //               borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5),
                                            //               border: Border.all(
                                            //                   color: Colors.grey)),
                                            //           child: IconButton(
                                            //               onPressed: decrement,
                                            //               icon: const Icon(
                                            //                 Icons.remove,
                                            //                 size: 15,
                                            //               ))),
                                            //       SizedBox(
                                            //         width: screenWidth * 0.03,
                                            //       ),
                                            //       Text(response?.data?.items?[index]
                                            //           .quantity
                                            //           .toString() ??
                                            //           ""),
                                            //       SizedBox(
                                            //         width: screenWidth * 0.03,
                                            //       ),
                                            //       Container(
                                            //           height: screenHeight * 0.035,
                                            //           width: screenWidth * 0.08,
                                            //           decoration: BoxDecoration(
                                            //               borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5),
                                            //               border: Border.all(
                                            //                   color: Colors.grey)),
                                            //           child: IconButton(
                                            //               onPressed: increment,
                                            //               icon: const Icon(
                                            //                 Icons.add,
                                            //                 size: 15,
                                            //               ))),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20,),

                                      Text(
                                        "\$ ${response?.data?.items?[index].total}" ??
                                            "",
                                        style: GoogleFonts.vazirmatn(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        (response?.data?.items?.isEmpty == null) ? const SizedBox() : SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        (response?.data?.items?.isEmpty == null) ? const SizedBox()  : AppButton(
                          text: "Checkout",
                          onPressed: () async {
                            Nav.push(context, const CheckoutScreen());
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
