import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/wallet_screen/receive_screen/receive_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/wallet_screen/send_screen/send_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/nav/nav.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
                  Text("Wallet",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Container(
                  height: screenHeight * 0.2,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xff599918),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Text("Wallet Balance",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text("\$ 100000",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: screenHeight * 0.02,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Nav.push(context, const SendScreen());
                      },
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("assets/icons/send.png"),
                              Text(
                                "Send",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Nav.push(context, const ReceiveScreen());
                      },
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset("assets/icons/receive.png"),
                              Text(
                                "Receive",
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  "Transactions",
                  style:
                      GoogleFonts.vazirmatn(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              //TODO it Will b In Listview
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Container(
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/send.png"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              "0xFca318f88f11af575a8C6D9b82b631dC9dA25b85",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 8),
                            ),
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
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/send.png"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              "0xFca318f88f11af575a8C6D9b82b631dC9dA25b85",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 8),
                            ),
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
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/receive.png"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              "0xFca318f88f11af575a8C6D9b82b631dC9dA25b85",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.black, fontSize: 8),
                            ),
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
            ],
          ),
        ),
      ),
    ));
  }
}
