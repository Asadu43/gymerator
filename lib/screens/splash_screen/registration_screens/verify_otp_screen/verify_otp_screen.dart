import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/create_new_password_screen/create_new_password_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  var code;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => VerifyOtpCubit(),
      child: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is FailedToVerifyCode) {
            showSnackBar(context, state.message);
          }
          if (state is VerifyOtpSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            Nav.pushReplace(context, CreateNewPasswordScreen(email: widget.email));
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
                            textStyle: const TextStyle(color: Colors.white),
                            numberOfFields: 4,
                            borderColor: Colors.white,
                            focusedBorderColor: Colors.green,
                            fillColor: Colors.white,
                            showFieldAsBox: false,
                            borderWidth: 4.0,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              code = verificationCode;
                              print(
                                "onSubmit $verificationCode",
                              );
                            },
                          ),
                          SizedBox(
                            height: screenHeight / 2.5,
                          ),
                          AppButton(
                            text: "Verify",
                            onPressed: () async {
                              await _onVerifyButtonPressed(context);
                              print("code..... $code");
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
    if (code == null) {
      showSnackBar(context, "Please enter Code");
    } else {
      context.read<VerifyOtpCubit>().verifyRequest(
            email: widget.email,
            code: int.parse(code),
          );
    }
  }
}
