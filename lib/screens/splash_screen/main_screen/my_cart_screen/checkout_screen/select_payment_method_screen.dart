import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../../../bloC/auth_cubit/create_order_cubit/create_order_cubit.dart';
import '../../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../../../ui_component/app_button.dart';
import '../../../../../ui_component/app_dialog_box.dart';
import '../../../../../ui_component/payment.dart';
import '../../../../../ui_component/show_snackbar.dart';
import '../../../../../utils/nav/nav.dart';
import '../../main_screen.dart';

class SelectPaymentMethodScreen extends StatefulWidget {
  final double totalAmount;
  final String deliveryAddress;
  final String billingAddress;
  final String payment;
  final double totalDiscount;
  final int totalProducts;
  final double totalPayingPrice;

  const SelectPaymentMethodScreen(
      {super.key,
      required this.totalAmount,
      required this.deliveryAddress,
      required this.billingAddress,
      required this.payment,
      required this.totalDiscount,
      required this.totalProducts,
      required this.totalPayingPrice});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  GetAllFavoriteProductApiResponse? response;
  var data;

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling stripe api
      data = await createPaymentIntent(
          // convert string to double
          amount: (int.parse(widget.totalPayingPrice.round().toString()) * 100)
              .toString(),
          currency: "USD",
          name: response?.data?.firstName ?? "",
          address: widget.deliveryAddress,
          postalCode: response?.data?.address?.postalCode ?? "",
          city: response?.data?.address?.city ?? "",
          state: response?.data?.address?.state ?? "",
          country: response?.data?.address?.country ?? "");

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: 'Test Merchant',
        paymentIntentClientSecret: data['client_secret'],
        // Customer keys
        customerEphemeralKeySecret: data['ephemeralKey'],
        customerId: data['id'],
        style: ThemeMode.dark,
        appearance: const PaymentSheetAppearance(
            colors:
                PaymentSheetAppearanceColors(background: Color(0xff3F710D))),
      ));
    } catch (e) {
      showSnackBar(context, "Error:  $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CreateOrderCubit()..featuredRequest(),
      child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
        listener: (context, state) {
          if (state is FailedToOrderCreate) {
            showSnackBar(
                context, state.response.message ?? "Create Order Failed");
          }
          if (state is CreateOrderSuccessfully) {
            showDialog(
              context: context,
              builder: (ctx) => PlaceholderDialog(
                icon: Image.asset(
                  "assets/icons/success.png",
                  width: screenWidth * 0.1,
                  height: screenHeight * 0.1,
                ),
                title: 'Payment Successfully',
                message:
                    'Thanks for your order. Your order has placed successfully. Please continue your order.',
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: AppButton(
                        text: "Continue Shopping",
                        onPressed: () async {
                          Nav.pushAndRemoveAllRoute(
                              context, const MainScreen());
                        }),
                  ),
                ],
              ),
            );

            Future.delayed(const Duration(seconds: 5), () {
              Nav.pushAndRemoveAllRoute(context, const MainScreen());
            });
          }
          if (state is AllFavoriteProductGetSuccessfully) {
            response = state.response;
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
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
                          Text("Order Summary",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.2),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delivery Address",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text(widget.deliveryAddress,
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp, color: Colors.grey)),
                            const Divider(thickness: 2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Billing Address",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text(widget.billingAddress,
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp, color: Colors.grey)),
                            const Divider(thickness: 2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Payment",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(height: screenHeight * 0.02),
                            Text(widget.payment,
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp, color: Colors.black)),
                            SizedBox(height: screenHeight * 0.01),
                            const Divider(thickness: 2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Subtotal",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(height: screenHeight * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${widget.totalProducts} Items Product",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp, color: Colors.grey)),
                                Text("\$ ${widget.totalAmount}",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp, color: Colors.grey)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp, color: Colors.grey)),
                                Text("\$ ${widget.totalDiscount}",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp, color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            const DottedLine(
                              dashLength: 5,
                              lineThickness: 2,
                              dashColor: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                Text("\$ ${widget.totalPayingPrice}",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.15,
                      ),
                      const Spacer(),
                      AppButton(
                        text: "Place Order",
                        onPressed: () async {
                          if (widget.payment == "Cash on Delivery") {
                            try {
                              await initPaymentSheet();
                              context.read<CreateOrderCubit>().createRequest(
                                  shippingAddress: widget.deliveryAddress,
                                  paymentAddress: widget.billingAddress,
                                  paymentMethod: widget.payment,
                                  paymentIntentId: data['id'],
                                  amount: int.parse(widget.totalPayingPrice
                                      .round()
                                      .toString()),
                                  currency: "USD");
                            } catch (e) {
                              print(e.toString());
                              showSnackBar(context, "Payment Failed");
                            }
                          } else {
                            try {
                              await initPaymentSheet();
                              await Stripe.instance.presentPaymentSheet();
                              context.read<CreateOrderCubit>().createRequest(
                                  shippingAddress: widget.deliveryAddress,
                                  paymentAddress: widget.billingAddress,
                                  paymentMethod: widget.payment,
                                  paymentIntentId: data['id'],
                                  amount: int.parse(widget.totalPayingPrice
                                      .round()
                                      .toString()),
                                  currency: "USD");
                            } catch (e) {
                              print(e.toString());

                              showSnackBar(context, "Payment Failed");
                            }
                          }
                        },
                      ),
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
}
