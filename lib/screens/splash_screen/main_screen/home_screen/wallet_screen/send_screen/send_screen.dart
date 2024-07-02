import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/wallet_screen/receive_screen/receive_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../ui_component/app_button.dart';
import '../../../../../../ui_component/app_textfield.dart';
import '../../../../../../utils/nav/nav.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                hintText: "address",
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
               AppTextField(
                hintText: "amount",
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              const Spacer(),
              AppButton(
                text: "Send",
                onPressed: () async {
                  Nav.push(context, const ReceiveScreen());
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
