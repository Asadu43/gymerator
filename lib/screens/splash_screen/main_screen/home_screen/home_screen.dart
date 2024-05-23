import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValue = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ListTile(
                  leading: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text("FAQ's",
                      style: GoogleFonts.barlow(
                          fontSize: 14, color: Colors.black)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu)),
                    Text("Hi, Asad",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_today_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none)),
                  ],
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Container(
                height: screenHeight * 0.25,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color(0xffFF6300).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Body Training\nWorkout",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text("Includes circuits to work \n every muscle",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 11.sp, color: Colors.grey)),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                            height: screenHeight * 0.07,
                            width: screenHeight * 0.18,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 5),
                                    blurRadius: 5.0)
                              ],
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                // stops: const [0.0, 1.0],
                                colors: [
                                  Color(0xffB14501),
                                  Color(0xff3F710D),
                                ],
                              ),
                              // color: Colors.deepPurple.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                // minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                              ),
                              onPressed: () {},
                              child: Text(
                                "Start Traning",
                                style: GoogleFonts.barlow(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/images/traning.png",
                          height: screenHeight * 0.25,
                          fit: BoxFit.fill,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text("Current Plan Intermediate",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
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
                        child: Image.asset("assets/images/begginer.png"),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Text("Beginner",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text("5-10 mins a day",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 8.sp, color: Colors.grey)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                        // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if ((checkboxValue == true) &&
                                (selectedIndex == 2)) {
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
                        child: Image.asset("assets/images/intermedate.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Intermediate",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text("10-20 mins a day",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 8.sp, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                        // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if ((checkboxValue == true) &&
                                (selectedIndex == 3)) {
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
                        child: Image.asset("assets/images/advance.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Advance",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text("15-30 mins a day",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 8.sp, color: Colors.grey)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                        // color: (checkboxValue == true && selectedIndex == 1) ? Colors.blue : Colors.red,
                        gradient: (checkboxValue == true && selectedIndex == 4)
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
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if ((checkboxValue == true) &&
                                (selectedIndex == 4)) {
                              setState(() {
                                checkboxValue = false;
                                selectedIndex = 0;
                              });
                            } else {
                              setState(() {
                                checkboxValue = true;
                                selectedIndex = 4;
                              });
                            }
                          });
                        },
                        child: Image.asset("assets/images/expert.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Expert",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    Text("20-35 mins a day",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 8.sp, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
