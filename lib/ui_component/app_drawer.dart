import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/bettery_screen/bettery_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/my_cart_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/favorite_products_screen/favorite_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/metamask_screen/metamask_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  GetAllFavoriteProductApiResponse? response;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // UserAccountsDrawerHeader(
            //   accountName: Text(
            //       "${response?.data?.firstName ?? ""} ${response?.data?.lastName ?? ""}"),
            //   accountEmail: Text(response?.data?.email ?? ""),
            //   decoration: const BoxDecoration(
            //     color: Color(0xff599918),
            //   ),
            //   currentAccountPicture: CircleAvatar(
            //     backgroundImage:response?.data?.profile == null ? null : NetworkImage(
            //       '${ApiConstants.baseUrl}/profile/${response?.data?.profile}',
            //     ),
            //     child: response?.data?.profile == null
            //         ? Text(
            //             response?.data?.firstName?[0].toUpperCase() ?? "",
            //             style: const TextStyle(
            //                 fontSize: 40, color: Colors.white),
            //           )
            //         : null,
            //   ),
            // ),
            // ListTile(
            //     onTap: () {
            //       Nav.push(context, const NftMarketPlaceScreen());
            //     },
            //     leading: CircleAvatar(
            //       backgroundColor: Colors.grey.shade400,
            //       radius: 25,
            //       child: Image.asset("assets/icons/nft.png"),
            //     ),
            //     title: Text("NFT Marketplace",
            //         style: GoogleFonts.vazirmatn(
            //             fontSize: 14, color: Colors.black)),
            //     trailing: const Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.black,
            //       size: 15,
            //     )),
            Image.asset(
              "assets/images/logo.png",
              height: screenHeight * 0.2,
              width: screenWidth * 0.4,
            ),
            ListTile(
                onTap: () {
                  Nav.push(context, const MetaMaskScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: Image.asset("assets/icons/metamask.png"),
                ),
                title: Text("Metamask",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.black,fontWeight:FontWeight.w400)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            ListTile(
                onTap: () {
                  Nav.push(context, const MyCartScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: Image.asset("assets/icons/cart.png"),
                ),
                title: Text("Cart",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.black,fontWeight:FontWeight.w400)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 12,
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            ListTile(
                onTap: () {
                  Nav.push(context, const FavoriteProductsScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: Image.asset("assets/icons/heart.png"),
                ),
                title: Text("Favorite product",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.black,fontWeight:FontWeight.w400)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            ListTile(
                onTap: () {
                  Nav.push(context, const BatteryScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: const Icon(Icons.battery_charging_full),
                ),
                title: Text("Energize life",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 12.sp, color: Colors.black,fontWeight: FontWeight.w400)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                )),
          ],
        ),
      ),
    );
  }
}
