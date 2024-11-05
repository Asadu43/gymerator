import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/select_payment_method_screen.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../ui_component/app_button.dart';
import '../../../../../ui_component/app_textfield.dart';
import '../../../../../utils/nav/nav.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  final double totalDiscount;
  final int totalProducts;
  final double totalPayingPrice;

  const CheckoutScreen(
      {super.key,
      required this.totalAmount,
      required this.totalDiscount,
      required this.totalProducts,
      required this.totalPayingPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();

  int _paymentMethodValue = -1;
  int _termAndConditionValue = -1;

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  Text("Checkout",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AppTextField(
                controller: deliveryAddressController,
                hintText: "Delivery Address",
                cursorColor: Colors.black,
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AppTextField(
                controller: billingAddressController,
                hintText: "Billing Address",
                cursorColor: Colors.black,
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.04,
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
                elevation: 2,
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
                        title: Text(
                          "Card",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 12.sp,
                          ),
                        ),
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
                        title: Text(
                          "Cash on Delivery",
                          style: GoogleFonts.vazirmatn(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
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
                      fontSize: 12.sp,
                      color: const Color(0xff3F710D),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              AppButton(
                text: "Continue",
                onPressed: () async {
                  if (deliveryAddressController.text.isEmpty) {
                    showSnackBar(context, "Please enter Delivery Address");
                  } else if (billingAddressController.text.isEmpty) {
                    showSnackBar(context, "Please enter Billing Address");
                  } else if (_paymentMethodValue == -1) {
                    showSnackBar(context, "Please select payment method");
                  } else if (_termAndConditionValue == -1) {
                    showSnackBar(context, "Please select terms and conditions");
                  } else {
                    if (_paymentMethodValue == 1) {
                      Nav.push(
                          context,
                          SelectPaymentMethodScreen(
                            totalAmount: widget.totalAmount,
                            deliveryAddress: deliveryAddressController.text,
                            billingAddress: billingAddressController.text,
                            payment: 'Card',
                            totalDiscount: widget.totalDiscount,
                            totalProducts: widget.totalProducts,
                            totalPayingPrice: widget.totalPayingPrice,
                          ));
                    } else {
                      Nav.push(
                          context,
                          SelectPaymentMethodScreen(
                            totalAmount: widget.totalAmount,
                            deliveryAddress: deliveryAddressController.text,
                            billingAddress: billingAddressController.text,
                            payment: 'Cash on Delivery',
                            totalDiscount: widget.totalDiscount,
                            totalProducts: widget.totalProducts,
                            totalPayingPrice: widget.totalPayingPrice,
                          ));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
