import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../../../bloC/auth_cubit/create_order_cubit/create_order_cubit.dart';
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
  final String name;
  final String currency;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  const SelectPaymentMethodScreen(
      {super.key,
      required this.totalAmount,
      required this.deliveryAddress,
      required this.billingAddress,
      required this.name,
      required this.currency,
      required this.city,
      required this.state,
      required this.country,
      required this.postalCode});

  @override
  State<SelectPaymentMethodScreen> createState() =>
      _SelectPaymentMethodScreenState();
}

class _SelectPaymentMethodScreenState extends State<SelectPaymentMethodScreen> {
  int _paymentMethodValue = -1;
  int _termAndConditionValue = -1;
  var data;

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling stripe api
      data = await createPaymentIntent(
          // convert string to double
          amount: (int.parse(widget.totalAmount.round().toString()) * 100)
              .toString(),
          currency: widget.currency,
          name: widget.name,
          address: widget.deliveryAddress,
          postalCode: widget.postalCode,
          city: widget.city,
          state: widget.state,
          country: widget.country);

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
      create: (context) => CreateOrderCubit(),
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
                          Text("Select Payment",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("Payment method",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                activeColor: const Color(0xff3F710D),
                                groupValue: _paymentMethodValue,
                                fillColor: WidgetStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return const Color(0xff3F710D);
                                    }
                                    return const Color(0xff3F710D);
                                  },
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethodValue = value!;
                                  });
                                },
                                title: const Text("Card"),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                              ),
                              RadioListTile(
                                value: 2,
                                activeColor: const Color(0xff3F710D),
                                groupValue: _paymentMethodValue,
                                fillColor: WidgetStateProperty.resolveWith(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return const Color(0xff3F710D);
                                    }
                                    return const Color(0xff3F710D);
                                  },
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _paymentMethodValue = value!;
                                  });
                                },
                                title: const Text("Cash on Delivery"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RadioListTile(
                          value: 1,
                          activeColor: const Color(0xff3F710D),
                          fillColor: WidgetStateProperty.resolveWith(
                            (states) {
                              if (states.contains(WidgetState.selected)) {
                                return const Color(0xff3F710D);
                              }
                              return const Color(0xff3F710D);
                            },
                          ),
                          groupValue: _termAndConditionValue,
                          onChanged: (value) {
                            setState(() {
                              _termAndConditionValue = value!;
                            });
                          },
                          title: Text(
                            "I Agree Terms & Conditions",
                            style: GoogleFonts.vazirmatn(
                              color: const Color(0xff3F710D),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      AppButton(
                        text: "Place Order",
                        onPressed: () async {
                          if (_paymentMethodValue == -1) {
                            showSnackBar(
                                context, "Please select payment method");
                          } else if (_termAndConditionValue == -1) {
                            showSnackBar(
                                context, "Please select terms and conditions");
                          } else {
                            if (_paymentMethodValue == 1) {
                              try {
                                await initPaymentSheet();
                                await Stripe.instance.presentPaymentSheet();
                                context.read<CreateOrderCubit>().createRequest(
                                    shippingAddress: widget.deliveryAddress,
                                    paymentAddress: widget.billingAddress,
                                    paymentMethod: 'Card',
                                    paymentIntentId: data['id'],
                                    amount: int.parse(
                                        widget.totalAmount.round().toString()),
                                    currency: widget.currency);
                              } catch (e) {
                                print(e.toString());

                                showSnackBar(context, "Payment Failed");
                              }
                            } else {
                              context.read<CreateOrderCubit>().createRequest(
                                  shippingAddress: widget.deliveryAddress,
                                  paymentAddress: widget.billingAddress,
                                  paymentMethod: "Cash on Delivery",
                                  paymentIntentId: "",
                                  amount: int.parse(
                                      widget.totalAmount.round().toString()),
                                  currency: widget.currency);
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
