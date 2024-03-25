import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors/appColors.dart';
import '../../utils/nav/nav.dart';
import 'metamask_screen/metamask_screen.dart';

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
      Nav.pushReplace(context, const MetaMaskScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final fontSize = screenWidth * 0.05;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/splashBackground.png'), // Replace with your image asset path
        fit: BoxFit.cover, // You can adjust the fit property as needed
      )),
      child: Column(
        children: [
          SizedBox(height: screenHeight / 3),
          Image.asset(
            "assets/images/logo.png",
            height: 216,
            width: 246,
          ),
          Text(
            "Gymerator App",
            style: GoogleFonts.barlow(fontSize: 32, color: AppColors.white),
          )
        ],
      ),
    )));
  }
}
