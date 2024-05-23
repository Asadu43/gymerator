import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/verify_otp_screen/verify_otp_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../utils/app_colors/appColors.dart';
import '../../../../utils/nav/nav.dart';
import '../create_new_password_screen/create_new_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
              Text("Forgot Password",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white)),
              Text(
                  "Enter your email for verification process, we will send a link for password update",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 12.sp, color: Colors.grey)),
              const SizedBox(
                height: 20,
              ),
              const AppTextField(
                hintText: "Enter your email",
                icon: Icon(Icons.email_outlined),
              ),
              SizedBox(
                height: screenHeight / 2.5,
              ),
              AppButton(
                text: "Send Email",
                onPressed: () async {
                  Nav.push(context, const VerifyOtpScreen());
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
