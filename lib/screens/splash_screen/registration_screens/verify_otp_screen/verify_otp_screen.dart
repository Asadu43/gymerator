import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/create_new_password_screen/create_new_password_screen.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/login_screen/login_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  final int isFromSignUp;

  const VerifyOtpScreen(
      {super.key, required this.email, required this.isFromSignUp});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  var code;

  bool _isTextVisible = true;

  void _hideTextForOneMinute() {
    context.read<VerifyOtpCubit>().forgetRequest(
          email: widget.email,
        );
    setState(() {
      _isTextVisible = false;
    });

    Timer(const Duration(minutes: 1), () {
      setState(() {
        _isTextVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isFromSignUp);
    return BlocProvider(
      create: (context) => VerifyOtpCubit(),
      child: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) {
          if (state is FailedToVerifyCode) {
            showSnackBar(context, state.message);
          }
          if (state is VerifyOtpSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            if (widget.isFromSignUp == 1) {
              Nav.pushReplace(
                  context, CreateNewPasswordScreen(email: widget.email));
            }else if (widget.isFromSignUp == 2){
              Nav.pushAndRemoveAllRoute(context, const LoginScreen());
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: 1.sh,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    // Replace with your image asset path
                    fit: BoxFit
                        .cover, // You can adjust the fit property as needed
                  )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 70.h),
                        Image.asset('assets/images/logo_g.png'),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Verify OTP",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
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
                        SizedBox(height: 20.h),
                        if (_isTextVisible)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Did not receive OTP? ",
                                  style: GoogleFonts.barlow(
                                      fontSize: 14.sp, color: Colors.grey)),
                              InkWell(
                                onTap: _hideTextForOneMinute,
                                child: Text("Resend OTP",
                                    style: GoogleFonts.barlow(
                                        fontSize: 14, color: Colors.white)),
                              ),
                            ],
                          ),
                        if (!_isTextVisible)
                          Text("OTP send successfully please check your email ",
                              style: GoogleFonts.barlow(
                                  fontSize: 14.sp, color: Colors.white)),
                        const Spacer(),
                        AppButton(
                          text: "Verify",
                          onPressed: () async {
                            await _onVerifyButtonPressed(context);
                            print("code..... $code");
                          },
                        ),
                        SizedBox(
                          height: 20.h,
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
