import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/user_cart_product_cubit/user_cart_products_cubit.dart';
import 'package:gymmerator/models/api_response/GetAllUserProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/ItemQuantity.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/checkout_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
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
                            SizedBox(width: 0.25.sw,),
                            Text(" My Cart",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),

                          ],
                        ),
                        SizedBox(
                          height: 0.02.sh,
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
                                              BorderRadius.circular(16.r),
                                          icon: Icons.delete,
                                          label: 'delete',

                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.only(
                                          top: 8.h, left: 8.w, right: 8.w),
                                      child: Container(
                                        height: 0.1.sh,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 70.w,
                                                height: 90.h,
                                                // color: Colors.red,
                                                child: Padding(
                                                  padding:
                                                       EdgeInsets.all(4.h),
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
                                              SizedBox(width: 20.w),
                                              SizedBox(
                                                width: 0.3.sw,
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
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
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
                                               SizedBox(
                                                width: 20.w,
                                              ),
                                              Text(
                                                "\$ ${response?.data?.items?[index].total}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.vazirmatn(
                                                    color: Colors.black,
                                                    fontSize: 14.sp,fontWeight: FontWeight.w600),
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
                          height: 0.05.sh,
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
                                         Text(
                                          "Total Price Before Discount ",
                                          style: GoogleFonts.vazirmatn(fontSize: 12.sp),
                                        ),
                                        Text(
                                          "\$ ${response?.data?.subTotal}",
                                          style: GoogleFonts.vazirmatn(
                                            fontSize: 10.sp,
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
                                          style: GoogleFonts.vazirmatn(fontSize: 12.sp),
                                        ),
                                        Text(
                                          "\$ ${response?.data?.discount?.toStringAsFixed(2)}",
                                          style: GoogleFonts.vazirmatn(
                                            color: Colors.grey,
                                            fontSize: 10.sp,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Total Price \$ ${response?.data?.total.toString()}",
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? const SizedBox()
                            : SizedBox(
                                height: 0.1.sh,
                              ),
                        (response?.data == null ||
                                response?.data?.items?.isEmpty == true)
                            ? const SizedBox()
                            : Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.w),
                              child: AppButton(
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
