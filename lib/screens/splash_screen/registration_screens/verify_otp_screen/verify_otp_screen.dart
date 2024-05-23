import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/create_new_password_screen/create_new_password_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../utils/app_colors/appColors.dart';
import '../../../../utils/nav/nav.dart';


class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/background.png'), // Replace with your image asset path
                  fit: BoxFit.cover, // You can adjust the fit property as needed
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight / 14,
                  ),
                  Image.asset('assets/images/logo_g.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Verify OTP",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white)),
                  Text("Please Enter the 4 Digit Code Send  Your Email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vazirmatn(
                          fontSize: 12.sp, color: Colors.grey)),

                  OtpTextField(
                    numberOfFields: 4,
                    contentPadding: const EdgeInsets.all(20),
                    borderColor: Colors.white,
                    // focusedBorderColor: Colors.purple,
                    // styles: otpTextStyles,
                    showFieldAsBox: false,
                    borderWidth: 4.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here if necessary
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {

                    },
                  ),

                  SizedBox(
                    height: screenHeight / 2.5,
                  ),
                  AppButton(
                    text: "Verify",
                    onPressed: () async {
                      Nav.push(context, const CreateNewPasswordScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
