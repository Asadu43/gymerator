import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import '../../../../models/api_response/GetAllFavoriteProductApiResponse.dart';
import '../../../../ui_component/app_drawer.dart';
import '../../../../ui_component/loading_screen_animation.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        if (state is FailedToGetProduct) {}
        if (state is AllFavoriteProductGetSuccessfully) {
          response = state.response;
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
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
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
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/icons/coin.png",
                                fit: BoxFit.cover),
                             SizedBox(
                              width: 10.w,
                            ),
                            Text("10",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 8.w),
                    child: Text("Energize your life",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.h),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xff599918).withOpacity(0.15),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 150.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gym Prime Charger \n(250mAh,GaNPrime)",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "250mAh High-Efficiency\nCharger",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        height: 50.h,
                                        width: 100.w,
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
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "10 Coin",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 11.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                "assets/images/bettery_one.png",
                                fit: BoxFit.scaleDown,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Card(
                      elevation: 0,
                      color: const Color(0xff599918).withOpacity(0.15),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 150.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Gym Prime Charger \n(250mAh,GaNPrime)",
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "250mAh High-Efficiency\nCharger",
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 9.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      height: 50.h,
                                      width: 100.w,
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
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.transparent),
                                          shadowColor: WidgetStateProperty.all(
                                              Colors.transparent),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "15 Coin",
                                          style: GoogleFonts.vazirmatn(
                                            fontSize: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/bettery_two.png",
                              fit: BoxFit.scaleDown,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xff599918).withOpacity(0.15),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 150.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gym Prime Charger \n(250mAh,GaNPrime)",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "250mAh High-Efficiency\nCharger",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 9.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height:  10.h,
                                      ),
                                      Container(
                                        height:  50.h,
                                        width: 100.w,
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
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: WidgetStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "20 Coin",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 11.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                "assets/images/bettery_three.png",
                                fit: BoxFit.scaleDown,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
