import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/verify_otp_screen/verify_otp_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

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
              context,
              VerifyOtpScreen(email: emailController.text,isFromSignUp: 1),
            );
            emailController.clear();
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: Container(
                height: 1.sh,
                width: 1.sw,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_g.png',
                          width: 100.w, // Adjust width based on screen size
                          height: 100.h, // Adjust height based on screen size
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Forgot Password",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Enter your email for verification process, we will send a link for password update",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.vazirmatn(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        const Spacer(),
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
          );
        },
      ),
    );
  }

  Future<void> _onVerifyButtonPressed(BuildContext context) async {
    if (emailController.text.isEmpty) {
      showSnackBar(context, "Please enter your email");
    } else {
      context.read<ForgetPasswordCubit>().forgetRequest(
            email: emailController.text,
          );
    }
  }
}