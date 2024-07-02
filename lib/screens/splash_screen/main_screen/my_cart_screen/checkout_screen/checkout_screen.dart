import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/payment_screen/payment_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../ui_component/app_button.dart';
import '../../../../../ui_component/app_textfield.dart';
import '../../../../../utils/nav/nav.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _groupValue = -1;

  int _selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                    Text("Send",
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
                  hintText: "Delivery Address",
                  color: Colors.grey,
                  fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                 AppTextField(
                  hintText: "Promo Code",
                  color: Colors.grey,
                  fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                 AppTextField(
                  hintText: "Billing Address",
                  color: Colors.grey,
                  fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
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
                          groupValue: _groupValue,
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.selected)) {
                                return const Color(0xff3F710D);
                              }
                              return const Color(0xff3F710D);
                            },
                          ),
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value!;
                            });
                          },
                          title: const Text("Crypto Method"),
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
                          activeColor: Color(0xff3F710D),
                          groupValue: _groupValue,
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.selected)) {
                                return Color(0xff3F710D);
                              }
                              return Color(0xff3F710D);
                            },
                          ),
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value!;
                            });
                          },
                          title: const Text("Credit card"),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RadioListTile(
                    value: 1,
                    activeColor: const Color(0xff3F710D),
                    fillColor: MaterialStateProperty.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xff3F710D);
                        }
                        return const Color(0xff3F710D);
                      },
                    ),
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value!;
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
                  height: screenHeight * 0.18,
                ),
                AppButton(
                  text: "Confirm and Continue",
                  onPressed: () async {
                    Nav.push(context, const PaymentScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
