import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/verify_otp_screen/verify_otp_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloC/auth_cubit/forget_password_cubit/forget_password_cubit.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is FailedToSendCode) {
            showSnackBar(context, state.message);
          }
          if (state is CodeSendSuccessful) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            Nav.pushReplace(
                context, VerifyOtpScreen(email: emailController.text));
            emailController.clear();
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                          'assets/images/background.png'), // Replace with your image asset path
                      fit: BoxFit
                          .cover, // You can adjust the fit property as needed
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
                          AppTextField(
                            controller: emailController,
                            hintText: "Enter your email",
                            icon: const Icon(Icons.email_outlined),
                          ),
                          SizedBox(
                            height: screenHeight / 2.5,
                          ),
                          AppButton(
                            text: "Send Email",
                            onPressed: () async {
                              await _onVerifyButtonPressed(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onVerifyButtonPressed(BuildContext context) async {
    if (emailController.text.isEmpty) {
      showSnackBar(context, "Please enter email");
    } else {
      context.read<ForgetPasswordCubit>().forgetRequest(
            email: emailController.text,
          );
    }
  }
}
