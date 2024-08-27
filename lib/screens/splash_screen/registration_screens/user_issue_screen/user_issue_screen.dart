import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../utils/app_colors/app_colors.dart';

class UserIssueScreen extends StatefulWidget {
  const UserIssueScreen({super.key});

  @override
  State<UserIssueScreen> createState() => _UserIssueScreenState();
}

class _UserIssueScreenState extends State<UserIssueScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;

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
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Text("Do you have knee issue?",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                Text(
                    "Your coach will filter and reduce inappropriate exercises for you  Used Password.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vazirmatn(
                        fontSize: 11.sp, color: Colors.grey)),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: screenHeight * 0.09,
                    decoration: BoxDecoration(
                      // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                      gradient: (checkboxValue == true && selectedIndex == 1)
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // stops: const [0.0, 1.0],
                              colors: [
                                Color(0xffB14501),
                                Color(0xff3F710D),
                              ],
                            )
                          : const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // stops: const [0.0, 1.0],
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            if ((checkboxValue == true) &&
                                (selectedIndex == 1)) {
                              setState(() {
                                checkboxValue = false;
                                selectedIndex = 0;
                              });
                            } else {
                              setState(() {
                                checkboxValue = true;
                                selectedIndex = 1;
                              });
                            }
                          });
                        },
                        leading: Image.asset("assets/images/fine.png"),
                        tileColor:
                            ((checkboxValue == true) && (selectedIndex == 1))
                                ? Colors.blue
                                : Colors.red,
                        trailing: Checkbox(
                          checkColor: Colors.white,
                          focusColor: Colors.white,
                          activeColor: Colors.orange,
                          // fillColor: Colors.orange,
                          value: (checkboxValue == true && selectedIndex == 1),
                          shape: const CircleBorder(),
                          side: const BorderSide(color: Colors.white),
                          onChanged: (bool? value) {
                            setState(() {
                              checkboxValue = value!;
                              selectedIndex = 1;
                            });
                          },
                        ),
                        title: Text("No,I’m fine",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Container(
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    // color: (checkboxValue == true && selectedIndex == 2) ? Colors.blue : Colors.red,
                    gradient: (checkboxValue == true && selectedIndex == 2)
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // stops: const [0.0, 1.0],
                            colors: [
                              Color(0xffB14501),
                              Color(0xff3F710D),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // stops: const [0.0, 1.0],
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          if ((checkboxValue == true) && (selectedIndex == 2)) {
                            setState(() {
                              checkboxValue = false;
                              selectedIndex = 0;
                            });
                          } else {
                            setState(() {
                              checkboxValue = true;
                              selectedIndex = 2;
                            });
                          }
                        });
                      },
                      leading: Image.asset("assets/images/impect.png"),
                      tileColor:
                          ((checkboxValue == true) && (selectedIndex == 2))
                              ? Colors.blue
                              : Colors.red,
                      trailing: Checkbox(
                        checkColor: Colors.white,
                        focusColor: Colors.white,
                        activeColor: Colors.orange,
                        // fillColor: Colors.orange,
                        value: (checkboxValue == true && selectedIndex == 2),
                        shape: const CircleBorder(),
                        side: const BorderSide(color: Colors.white),
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxValue = value!;
                          });
                        },
                      ),
                      title: Text("No,I’m fine",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 11.sp, color: Colors.white)),
                      subtitle: Text("Friendly to over weight people",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 7.sp, color: Colors.grey)),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Container(
                  height: screenHeight * 0.09,
                  decoration: BoxDecoration(
                    // color:(checkboxValue == true && selectedIndex == 3) ? Colors.blue : Colors.red,
                    gradient: (checkboxValue == true && selectedIndex == 3)
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // stops: const [0.0, 1.0],
                            colors: [
                              Color(0xffB14501),
                              Color(0xff3F710D),
                            ],
                          )
                        : const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            // stops: const [0.0, 1.0],
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          if ((checkboxValue == true) && (selectedIndex == 3)) {
                            setState(() {
                              checkboxValue = false;
                              selectedIndex = 0;
                            });
                          } else {
                            setState(() {
                              checkboxValue = true;
                              selectedIndex = 3;
                            });
                          }
                        });
                      },
                      selectedTileColor: Colors.red,
                      tileColor:
                          ((checkboxValue == true) && (selectedIndex == 3))
                              ? Colors.blue
                              : Colors.red,
                      leading: Image.asset("assets/images/jumpping.png"),
                      trailing: Checkbox(
                        checkColor: Colors.white,
                        focusColor: Colors.white,
                        activeColor: Colors.orange,
                        // fillColor: Colors.orange,
                        value: (checkboxValue == true && selectedIndex == 3),
                        shape: const CircleBorder(),
                        side: const BorderSide(color: Colors.white),
                        onChanged: (bool? value) {
                          setState(() {
                            checkboxValue = value!;
                            print(checkboxValue);
                          });
                        },
                      ),
                      title: Text("No Jumping",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 11.sp, color: Colors.white)),
                      subtitle: Text("No noies, apartment friendly",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 7.sp, color: Colors.grey)),
                    ),
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: "Submit",
                  onPressed: () async {
                    // Nav.push(context, const ChoosePlanScreen());
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
