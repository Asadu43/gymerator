import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/schedule_workout_screen.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import '../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import '../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../notification_screen/notification_screen.dart';

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
                padding: EdgeInsets.all(8.w),
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
                              icon: const Icon(Icons.menu),
                            ),
                            Text(
                              "Hi, ${response?.data?.firstName ?? ""}",
                              style: GoogleFonts.vazirmatn(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Nav.push(context, const NotificationScreen());
                          },
                          icon: const Icon(Icons.notifications_none),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: Card(
                              elevation: 0,
                              color: const Color(0xffFF6300).withOpacity(0.15),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 180.h,
                                      child: Padding(
                                        padding: EdgeInsets.all(12.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Full Body Training\nWorkout",
                                              style: GoogleFonts.vazirmatn(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              "Includes circuits to work \nevery muscle",
                                              style: GoogleFonts.vazirmatn(
                                                fontSize: 11.sp,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Container(
                                              height: 0.07.sh,
                                              width: 0.18.sh,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0, 5),
                                                    blurRadius: 5.0,
                                                  ),
                                                ],
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color(0xffB14501),
                                                    Color(0xff3F710D),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: WidgetStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.transparent),
                                                  shadowColor:
                                                      WidgetStateProperty.all(
                                                          Colors.transparent),
                                                ),
                                                onPressed: () {
                                                  Nav.push(context,
                                                      const ScheduleWorkoutScreen());
                                                },
                                                child: Text(
                                                  "Start Training",
                                                  style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0.55.sw,
                            top: 10.h,
                            bottom: 20.h,
                            child: Image.asset(
                              "assets/images/traning.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text(
                        "Current Plan ${response?.data?.workoutLevel ?? ""}",
                        style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        workoutLevelTile(
                          title: "Beginner",
                          duration: "5-10 mins a day",
                          assetPath: "assets/images/begginer.png",
                          isSelected:
                              checkboxValue == true && selectedIndex == 1,
                          onTap: () {
                            if (checkboxValue == true && selectedIndex == 1) {
                              Nav.push(context, const ScheduleWorkoutScreen());
                            }
                          },
                        ),
                        workoutLevelTile(
                          title: "Intermediate",
                          duration: "10-20 mins a day",
                          assetPath: "assets/images/intermedate.png",
                          isSelected:
                              checkboxValue == true && selectedIndex == 2,
                          onTap: () {
                            if (checkboxValue == true && selectedIndex == 2) {
                              Nav.push(context, const ScheduleWorkoutScreen());
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        workoutLevelTile(
                          title: "Advance",
                          duration: "15-30 mins a day",
                          assetPath: "assets/images/advance.png",
                          isSelected:
                              checkboxValue == true && selectedIndex == 3,
                          onTap: () {
                            if (checkboxValue == true && selectedIndex == 3) {
                              Nav.push(context, const ScheduleWorkoutScreen());
                            }
                          },
                        ),
                        workoutLevelTile(
                          title: "Expert",
                          duration: "20-35 mins a day",
                          assetPath: "assets/images/expert.png",
                          isSelected:
                              checkboxValue == true && selectedIndex == 4,
                          onTap: () {
                            if (checkboxValue == true && selectedIndex == 4) {
                              Nav.push(context, const ScheduleWorkoutScreen());
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget workoutLevelTile({
    required String title,
    required String duration,
    required String assetPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 0.16.sh,
            width: 0.35.sw,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffB14501),
                        Color(0xff3F710D),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Image.asset(assetPath),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: GoogleFonts.vazirmatn(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.buttonColor : Colors.black,
            ),
          ),
          Text(
            duration,
            style: GoogleFonts.vazirmatn(fontSize: 10.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
