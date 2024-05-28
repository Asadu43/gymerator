import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../forget_password_screen/forget_password_screen.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
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
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight / 14,
                    ),
                    Image.asset('assets/images/logo_g.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Welcome!",
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
                      hintText: "Email",
                      icon: Icon(Icons.email_outlined),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AppTextField(
                      hintText: "password",
                      icon: Icon(Icons.lock_open_outlined),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Nav.push(context, const ForgetPasswordScreen());
                          },
                          child: Text("Forget Password?",
                              style: GoogleFonts.barlow(
                                  fontSize: 14, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      text: "Login",
                      onPressed: () async {
                        // Nav.push(context, const CompleteSetup());
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have an account? ",
                            style: GoogleFonts.barlow(
                                fontSize: 14, color: Colors.grey)),
                        InkWell(
                          onTap: () {
                            Nav.push(context, const SignupScreen());
                          },
                          child: Text("Create Account",
                              style: GoogleFonts.barlow(
                                  fontSize: 14, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: screenWidth / 3,
                            child: const Divider(color: Colors.grey)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("OR",
                            style: GoogleFonts.barlow(
                                fontSize: 14, color: Colors.white)),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: screenWidth / 3,
                            child: const Divider(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 53,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 30,
                            width: 30,
                          ),
                          Text("Sign in with Google",
                              style: GoogleFonts.barlow(
                                  fontSize: 14, color: Colors.white)),
                          const SizedBox(),
                        ],
                      ),
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
