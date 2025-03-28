import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/LoginWithGoogleApiResponse.dart';
import 'package:gymmerator/models/api_response/SignInApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/user_info_screen/user_info_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../bloC/auth_cubit/signin_cubit/sign_in_cubit.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../../main_screen/main_screen.dart';
import '../forget_password_screen/forget_password_screen.dart';
import '../signup_screen/signup_screen.dart';
import '../workout_plan_screen/workout_plan_screen.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  SignInApiResponse? response;
  LoginWithGoogleApiResponse? googleResponse;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInFailed) {
            showSnackBar(context, state.message);
          }
          if (state is SignInSuccessful) {
            response = state.response;
            emailController.clear();
            passwordController.clear();
            showSnackBar(context, response?.message ?? "Sign In Successfully",
                type: SnackBarType.success);

            if (response?.data?.isRequiredInfoAdded == true &&
                response?.data?.isAccepted == true) {
              Nav.pushAndRemoveAllRoute(context, const MainScreen());
            } else if (response?.data?.isRequiredInfoAdded == true &&
                response?.data?.isAccepted == false) {
              Nav.pushAndRemoveAllRoute(context, const WorkoutPlanScreen());
            } else {
              Nav.push(context, const UserInfoScreen());
            }
          }

          if (state is LoginWithGoogleFailed) {
            showSnackBar(context, state.message);
          }
          if (state is LoginWithGoogleSuccessfully) {
            googleResponse = state.response;
            emailController.clear();
            passwordController.clear();
            showSnackBar(
                context, googleResponse?.message ?? "Sign In Successfully",
                type: SnackBarType.success);

            if (googleResponse?.data?.isRequiredInfoAdded == true &&
                response?.data?.isAccepted == true) {
              Nav.pushAndRemoveAllRoute(context, const MainScreen());
            } else if (response?.data?.isRequiredInfoAdded == true &&
                response?.data?.isAccepted == false) {
              Nav.pushAndRemoveAllRoute(context, const WorkoutPlanScreen());
            } else {
              Nav.push(context, const UserInfoScreen());
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                height: 1.sh, // full screen height
                width: 1.sw, // full screen width
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Spacer(),
                        Image.asset(
                          'assets/images/logo_g.png',
                          width: 0.5.sw, // responsive width for logo
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "Welcome!",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "Please Sign in to get all the features",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 17.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 0.04.sh),
                        AppTextField(
                          controller: emailController,
                          hintText: "Email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        SizedBox(height: 0.03.sh),
                        AppTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                          icon: const Icon(Icons.lock_open_outlined),
                        ),
                        SizedBox(height: 0.01.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Nav.push(context, const ForgetPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.03.sh),
                        AppButton(
                          text: "Login",
                          onPressed: () async {
                            await _onSignInButtonPressed(context);
                          },
                        ),
                        SizedBox(height: 0.01.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Do you have an account? ",
                              style: GoogleFonts.vazirmatn(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Nav.push(context, const SignupScreen());
                              },
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.vazirmatn(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.03.sh),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.01.sw),
                              child: Text(
                                "OR",
                                style: GoogleFonts.vazirmatn(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.03.sh),
                        InkWell(
                          onTap: () async {
                            User? user = await _authService.signInWithGoogle();
                            if (user != null) {
                              context.read<SignInCubit>().loginWithGoogle(
                                    displayName: user.displayName ?? "",
                                    email: user.email ?? "",
                                    phoneNumber: user.phoneNumber ?? "",
                                    photoURL: user.photoURL ?? "",
                                  );
                            } else {
                              showSnackBar(context, 'Sign in failed');
                            }
                          },
                          child: Container(
                            height: 53.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/google.png',
                                  height: 0.05.sh,
                                  width: 0.05.sw,
                                ),
                                Text(
                                  "Sign in with Google",
                                  style: GoogleFonts.vazirmatn(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 0.02.sh),
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

  Future<void> _onSignInButtonPressed(BuildContext context) async {
    if (emailController.text.isEmpty) {
      showSnackBar(context, "Please enter email");
    } else if (passwordController.text.isEmpty) {
      showSnackBar(context, "Please enter password");
    } else {
      context.read<SignInCubit>().signIn(
            email: emailController.text,
            password: passwordController.text,
          );
    }
  }
}
