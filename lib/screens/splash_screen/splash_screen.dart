import 'package:flutter/material.dart';

import '../../utils/nav/nav.dart';
import 'main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 5 seconds and then navigate to the next screen
    Future.delayed(const Duration(seconds: 5), () {
      Nav.pushReplace(context, const MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
            'assets/images/splash_background.png'), // Replace with your image asset path
        fit: BoxFit.cover, // You can adjust the fit property as needed
      )),
      child: Column(
        children: [
          SizedBox(height: screenHeight / 3),
          Image.asset(
            "assets/images/logo.png",
            height: screenHeight * 0.3,
            width: screenWidth * 0.55,
          )
        ],
      ),
    ));
  }
}
