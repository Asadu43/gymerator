import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/SignInApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/user_info_screen/user_info_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloC/auth_cubit/signin_cubit/sign_in_cubit.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';
import '../../main_screen/main_screen.dart';
import '../forget_password_screen/forget_password_screen.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInApiResponse? response;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            showSnackBar(context, response?.message ?? "Sign In Successfully", type: SnackBarType.success);

            if(response?.data?.isRequiredInfoAdded == true){
              Nav.pushAndRemoveAllRoute(context, const MainScreen());
            }else {
              Nav.push(context, const UserInfoScreen());
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                        'assets/images/background.png'), // Replace with your image asset path
                    fit: BoxFit
                        .cover, // You can adjust the fit property as needed
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenHeight / 7.5,
                            ),
                            Image.asset('assets/images/logo_g.png'),
                            SizedBox(
                              height: screenHeight * 0.050,
                            ),
                            Text("Welcome!",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white)),
                            Text("Please Sign in to get all the features",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 12.sp, color: Colors.grey)),
                            SizedBox(
                              height: screenHeight * 0.040,
                            ),
                            AppTextField(
                              controller: emailController,
                              hintText: "Email",
                              icon: const Icon(Icons.email_outlined),
                            ),
                            SizedBox(
                              height: screenHeight * 0.030,
                            ),
                            AppTextField(
                              controller: passwordController,
                              hintText: "password",
                              icon: const Icon(Icons.lock_open_outlined),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Nav.push(
                                        context, const ForgetPasswordScreen());
                                  },
                                  child: Text("Forget Password?",
                                      style: GoogleFonts.barlow(
                                          fontSize: 14, color: Colors.white)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.040,
                            ),
                            AppButton(
                              text: "Login",
                              onPressed: () async {
                                await _onSignInButtonPressed(context);
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
                            SizedBox(
                              height: screenHeight * 0.040,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: screenWidth / 3,
                                    child: const Divider(color: Colors.grey)),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text("OR",
                                    style: GoogleFonts.barlow(
                                        fontSize: 14, color: Colors.white)),
                                const SizedBox(
                                  width: 16,
                                ),
                                SizedBox(
                                    width: screenWidth / 3,
                                    child: const Divider(color: Colors.grey)),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.040,
                            ),
                            Container(
                              height: screenHeight * 0.07,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            const SizedBox(height: 20),
                          ],
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
