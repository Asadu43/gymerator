import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gymmerator/screens/splash_screen/splash_screen.dart';
import 'package:sizer/sizer.dart';

import 'screens/splash_screen/registration_screens/user_info_screen/user_info_screen.dart';

void main() {
  Stripe.publishableKey = 'pk_test_51IxRoaCVPPCU0vw3fI0PKNS2YPCBg48h4VSbMUD5c0VoeBghcfKsRiWgy20pz3HekcTFWiaCrIcZlkHGbdAHf3bB00vok4FEDh';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gymmerator',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const UserInfoScreen(),
        );
      },
    );
  }
}
