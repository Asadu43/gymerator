import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../ui_component/app_button.dart';
import '../../../../../../../ui_component/app_dialog_box.dart';
import '../../../../../../../utils/nav/nav.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
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
                      Text("Street: #2, Liberty Market Gulberg, Lahore 12345",
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
                      Text("Street: #2, Liberty Market Gulberg, Lahore 12345",
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
                      Text("Credit Card",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 12.sp, color: Colors.black)),
                      Text("1234-5678-9012-3456",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 12.sp, color: Colors.grey)),
                      Text("08/2025",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 12.sp, color: Colors.grey)),
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
                          Text("2 Items Product",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp, color: Colors.grey)),
                          Text("\$ 15.00",
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
                          Text("\$ 3.00",
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
                          Text("\$12.00",
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
                AppButton(
                  text: "Submit Order",
                  onPressed: () async {
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
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: AppButton(
                                text: "Continue Shopping",
                                onPressed: () async {
                                  Nav.pop(context);
                                }),
                          ),
                          InkWell(
                            onTap: () {
                              Nav.pop(context);
                            },
                            child: Center(
                              child: Text("Cancel",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 12.sp, color: Colors.grey)),
                            ),
                          ),
                        ],
                      ),
                    );
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
