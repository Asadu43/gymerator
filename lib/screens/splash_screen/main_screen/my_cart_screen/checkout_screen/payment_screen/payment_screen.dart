import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/payment_screen/order_summary_screen/order_summary_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../ui_component/app_button.dart';
import '../../../../../../ui_component/app_textfield.dart';
import '../../../../../../utils/nav/nav.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int saveCard = -1;
  int payPalCard = -1;

  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text("Payment Method",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text("\$ 32.00",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("View detailed order",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp, color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                          "Credit/Debit Card",
                          style: GoogleFonts.vazirmatn(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/visa.png",
                          width: 60,
                          height: 60,
                        ),
                        Image.asset(
                          "assets/images/master.png",
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                      "Pay securely with your Bank Account using Visa or Mastercard",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 11.sp, color: Colors.grey)),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const AppTextField(
                  hintText: "Card Number",
                  color: Colors.grey,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const AppTextField(
                  hintText: "Card Name",
                  color: Colors.grey,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.060,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            // icon: icon,
                            hintText: "MM/YY",
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.barlow(
                                fontSize: 14, color: Colors.grey)),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.060,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextField(
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            // icon: icon,
                            hintText: "CVC",
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.barlow(
                                fontSize: 14, color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                RadioListTile(
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
                  groupValue: saveCard,
                  onChanged: (value) {
                    setState(() {
                      saveCard = value!;
                    });
                  },
                  title: Text(
                    "Save card for future payments",
                    style: GoogleFonts.vazirmatn(
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
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
                        groupValue: payPalCard,
                        onChanged: (value) {
                          setState(() {
                            payPalCard = value!;
                          });
                        },
                        title: Text(
                          "PayPal",
                          style: GoogleFonts.vazirmatn(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/paypal.png",
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                      "Pay securely with your Bank Account using Visa or Mastercard",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 11.sp, color: Colors.grey)),
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                AppButton(
                  text: "Confirm and Continue",
                  onPressed: () async {
                    Nav.push(context, const OrderSummaryScreen());
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
