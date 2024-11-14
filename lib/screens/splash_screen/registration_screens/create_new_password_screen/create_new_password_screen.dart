import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/update_password_cubit/update_password_cubit.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/login_screen/login_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;

  const CreateNewPasswordScreen({super.key, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
        listener: (context, state) {
          if (state is PasswordUpdateFailed) {
            showSnackBar(context, state.message);
          }
          if (state is UpdatePasswordSuccessfully) {
            password1Controller.clear();
            password2Controller.clear();
            showSnackBar(context, state.message, type: SnackBarType.success);
            Nav.pushAndRemoveAllRoute(context, const LoginScreen());
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
                  // Replace with your image asset path
                  fit:
                      BoxFit.cover, // You can adjust the fit property as needed
                )),
                child: SafeArea(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_g.png',
                          width: 100.w, // Adjust width based on screen size
                          height: 100.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Create New Password",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white)),
                        Text(
                            "Your New Password Must Be Different from Previously Used Password.",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 12.sp, color: Colors.grey)),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextField(
                          controller: password1Controller,
                          hintText: "New Password",
                          obscureText: true,
                          icon: const Icon(Icons.lock_outline_sharp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppTextField(
                          controller: password2Controller,
                          hintText: "Confirm Password",
                          obscureText: true,
                          icon: const Icon(Icons.lock_outline_sharp),
                        ),
                        const Spacer(),
                        AppButton(
                          text: "Submit",
                          onPressed: () async {
                            _onSubmitButtonPressed(context);
                            // Nav.push(context, const CompleteSetup());
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

  Future<void> _onSubmitButtonPressed(BuildContext context) async {
    if (password1Controller.text.isEmpty) {
      showSnackBar(context, "Please enter password");
    } else if (password2Controller.text.isEmpty) {
      showSnackBar(context, "Please enter password");
    } else if (password1Controller.text != password2Controller.text) {
      showSnackBar(context, "Password not matched");
    } else {
      context.read<UpdatePasswordCubit>().updateRequest(
            email: widget.email,
            password: password1Controller.text,
          );
    }
  }
}
