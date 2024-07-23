import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/products_screen.dart';
import 'package:gymmerator/screens/splash_screen/splash_screen.dart';
import 'package:gymmerator/utils/internet_connection/dependency_injection.dart';
import 'package:sizer/sizer.dart';

import 'bloC/auth_cubit/forget_password_cubit/forget_password_cubit.dart';
import 'bloC/auth_cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'screens/splash_screen/registration_screens/user_info_screen/user_info_screen.dart';

void main() {
  Stripe.publishableKey =
  'pk_test_51IxRoaCVPPCU0vw3fI0PKNS2YPCBg48h4VSbMUD5c0VoeBghcfKsRiWgy20pz3HekcTFWiaCrIcZlkHGbdAHf3bB00vok4FEDh';
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VerifyOtpCubit(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gymmerator',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
