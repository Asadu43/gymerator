import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/nav/nav.dart';

class AccountSetup extends StatefulWidget {
  const AccountSetup({super.key});

  @override
  State<AccountSetup> createState() => _AccountSetupState();
}

class _AccountSetupState extends State<AccountSetup> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight / 8,
                ),
                Text("Account Setup",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                SizedBox(
                  height: screenHeight / 12,
                ),
                const AppTextField(
                  hintText: "Name",
                  icon: Icon(Icons.person),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Email",
                  icon: Icon(Icons.email_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppTextField(
                  hintText: "Referral Code (optional)",
                  icon: Icon(Icons.lock_open_outlined),
                ),
                SizedBox(
                  height: screenHeight / 10,
                ),
                AppButton(
                  text: "Submit",
                  onPressed: () async {
                    // Nav.push(context, const CompleteSetup());
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do you have an account? ",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14, color: AppColors.white)),
                    InkWell(
                      onTap: () {
                        Nav.pop(context);
                      },
                      child: Text("Login",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 14,
                              color: AppColors.contentColorPurple)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
