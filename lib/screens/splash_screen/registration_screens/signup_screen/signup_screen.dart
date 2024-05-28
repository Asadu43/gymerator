import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/login_screen/login_screen.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/user_issue_screen/user_issue_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../user_info_screen/user_info_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                Text("Create Account",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                Text("Please Sign in to get all the features",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.grey)),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Enter your name",
                  icon: Icon(Icons.person_outline_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Enter your email",
                  icon: Icon(Icons.email_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Mobile Number",
                  icon: Icon(Icons.phone),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Address",
                  icon: Icon(Icons.location_on_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "password",
                  icon: Icon(Icons.lock_open_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  text: "Sign up",
                  onPressed: () async {
                    Nav.push(context, const UserInfoScreen());
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: GoogleFonts.barlow(
                            fontSize: 14, color: Colors.grey)),
                    InkWell(
                      onTap: () {
                        Nav.push(context, const LoginScreen());
                      },
                      child: Text("Sign In",
                          style: GoogleFonts.barlow(
                              fontSize: 14, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
