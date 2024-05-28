import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../utils/app_colors/app_colors.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Replace with your image asset path
            fit: BoxFit.cover, // You can adjust the fit property as needed
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
                Text("Create New Password",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                Text(
                    "Your New Password Must Be Differnt from Previously Used Password.",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.grey)),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "New Password",
                  icon: Icon(Icons.lock_outline_sharp),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "New Password",
                  icon: Icon(Icons.lock_outline_sharp),
                ),
                SizedBox(
                  height: screenHeight / 3.2,
                ),
                AppButton(
                  text: "Submit",
                  onPressed: () async {
                    // Nav.push(context, const CompleteSetup());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
