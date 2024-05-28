import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/checkout_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
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
                // TODO It will be Listview
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/super_iron.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Versus Super Iron",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: decrement,
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ))),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Text('$count'),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: increment,
                                          icon: const Icon(
                                            Icons.add,
                                            size: 15,
                                          ))),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "1000 ETH",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/super_iron.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Versus Super Iron",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: decrement,
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ))),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Text('$count'),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: increment,
                                          icon: const Icon(
                                            Icons.add,
                                            size: 15,
                                          ))),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "1000 ETH",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Container(
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/images/super_iron.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Versus Super Iron",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: decrement,
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ))),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Text('$count'),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: IconButton(
                                          onPressed: increment,
                                          icon: const Icon(
                                            Icons.add,
                                            size: 15,
                                          ))),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "1000 ETH",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.45,
                ),
                AppButton(
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
    );
  }
}
