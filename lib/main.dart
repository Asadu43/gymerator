import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymmerator/bloC/auth_cubit/notification_cubit/user_notification_cubit.dart';
import 'package:gymmerator/screens/splash_screen/splash_screen.dart';
import 'package:gymmerator/utils/internet_connection/dependency_injection.dart';

import 'bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import 'bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import 'bloC/auth_cubit/get_workout_plan_cubit/workout_plan_cubit.dart';
import 'bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import 'bloC/auth_cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'firebase_options.dart';

void main() async {
  Stripe.publishableKey =
      'pk_test_51IxRoaCVPPCU0vw3fI0PKNS2YPCBg48h4VSbMUD5c0VoeBghcfKsRiWgy20pz3HekcTFWiaCrIcZlkHGbdAHf3bB00vok4FEDh';
  DependencyInjection.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812), // base design size
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedProductCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateUserInfoCubit(),
        ),
        BlocProvider(
          create: (context) => VerifyOtpCubit(),
        ),
        BlocProvider(
          create: (context) => AllFavoriteProductsCubit(),
        ),
        BlocProvider(
          create: (context) => WorkoutPlanCubit(),
        ),
        BlocProvider(
          create: (context) => UserNotificationCubit(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gymerator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
