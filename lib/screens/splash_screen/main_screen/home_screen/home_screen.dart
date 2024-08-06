import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/schedule_workout_screen.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import 'package:sizer/sizer.dart';

import '../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import '../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../../ui_component/show_snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkboxValue = true;
  int selectedIndex = 2;
  GetAllFavoriteProductApiResponse? response;

  @override
  void initState() {
    context.read<AllFavoriteProductsCubit>().featuredRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AllFavoriteProductsCubit, AllFavoriteProductsState>(
      listener: (context, state) {
        if (state is FailedToGetProduct) {
          showSnackBar(context, state.response.error);
        }
        if (state is AllFavoriteProductGetSuccessfully) {
          response = state.response;
          if (response?.data?.workoutLevel == "Beginner") {
            selectedIndex = 1;
          } else if (response?.data?.workoutLevel == "Intermediate") {
            selectedIndex = 2;
          } else if (response?.data?.workoutLevel == "Advance") {
            selectedIndex = 3;
          } else if (response?.data?.workoutLevel == "Expert") {
            selectedIndex = 4;
          }
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: SafeArea(
              child: Scaffold(
            key: _scaffoldKey,
            drawer: const AppDrawer(),
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
                          Text("Hi, ${response?.data?.firstName ?? ""}",
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
                                Text(
                                    "Includes circuits to work \n every muscle",
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
                                      shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Colors.transparent),
                                      // elevation: MaterialStateProperty.all(3),
                                      shadowColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                    ),
                                    onPressed: () {
                                      Nav.push(context,
                                          const ScheduleWorkoutScreen());
                                    },
                                    child: Text(
                                      "Start Traning",
                                      style: GoogleFonts.barlow(
                                        fontSize: 14,
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
                    child: Text(
                        "Current Plan ${response?.data?.workoutLevel ?? ""}",
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
                              gradient:
                                  (checkboxValue == true && selectedIndex == 1)
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
                              gradient:
                                  (checkboxValue == true && selectedIndex == 2)
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
                              child:
                                  Image.asset("assets/images/intermedate.png"),
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
                              gradient:
                                  (checkboxValue == true && selectedIndex == 3)
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
                              gradient:
                                  (checkboxValue == true && selectedIndex == 4)
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
          )),
        );
      },
    );
  }
}
