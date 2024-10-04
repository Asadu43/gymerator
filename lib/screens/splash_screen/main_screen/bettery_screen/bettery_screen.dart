import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                          Image.asset("assets/icons/coin.png",
                              fit: BoxFit.cover),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("10",
                              style: GoogleFonts.vazirmatn(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Text("Energize your life",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xff599918).withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gym Prime Charger \n(250mAh,GaNPrime)",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
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
                                        height: screenHeight * 0.025,
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenHeight * 0.18,
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
                                              BorderRadius.circular(10),
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
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "10 Coin",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 12.sp,
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
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                      elevation: 0,
                      color: const Color(0xff599918).withOpacity(0.15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.23,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Gym Prime Charger \n(250mAh,GaNPrime)",
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
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
                                      height: screenHeight * 0.025,
                                    ),
                                    Container(
                                      height: screenHeight * 0.07,
                                      width: screenHeight * 0.18,
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
                                          shadowColor: WidgetStateProperty.all(
                                              Colors.transparent),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "15 Coin",
                                          style: GoogleFonts.vazirmatn(
                                            fontSize: 12.sp,
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
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Card(
                        elevation: 0,
                        color: const Color(0xff599918).withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Gym Prime Charger \n(250mAh,GaNPrime)",
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
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
                                        height: screenHeight * 0.025,
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenHeight * 0.18,
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
                                              BorderRadius.circular(10),
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
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                          ),
                                          onPressed: () {},
                                          child: Text(
                                            "20 Coin",
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 12.sp,
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
