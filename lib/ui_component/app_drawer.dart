import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import 'package:gymmerator/models/api_response/GetAllFavoriteProductApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/nft_market_place_screen/nft_market_place_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/wallet_screen/wallet_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/my_cart_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/favorite_products_screen/favorite_products_screen.dart';
import 'package:gymmerator/screens/splash_screen/metamask_screen/metamask_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:gymmerator/utils/nav/nav.dart';

import '../utils/api_constants/api_constants.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
        }
      },
      builder: (context, state) {
        return LoadingScreenAnimation(
          isLoading: state is LoadingState,
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                        "${response?.data?.firstName ?? ""} ${response?.data?.lastName ?? ""}"),
                    accountEmail: Text(response?.data?.email ?? ""),
                    decoration: const BoxDecoration(
                      color: Color(0xff599918),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:response?.data?.profile == null ? null : NetworkImage(
                        '${ApiConstants.baseUrl}/profile/${response?.data?.profile}',
                      ),
                      child: response?.data?.profile == null
                          ? Text(
                              response?.data?.firstName?[0].toUpperCase() ?? "",
                              style: const TextStyle(
                                  fontSize: 40, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
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
                  ListTile(
                      onTap: () {
                        Nav.push(context, const MetaMaskScreen());
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade400,
                        radius: 25,
                        child: Image.asset("assets/icons/metamask.png"),
                      ),
                      title: Text("Matamask",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 14, color: Colors.black)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      )),
                  // ListTile(
                  //     onTap: () {
                  //       Nav.push(context, const WalletScreen());
                  //     },
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.grey.shade400,
                  //       radius: 25,
                  //       child: Image.asset("assets/icons/wallet.png"),
                  //     ),
                  //     title: Text("Wallet",
                  //         style: GoogleFonts.vazirmatn(
                  //             fontSize: 14, color: Colors.black)),
                  //     trailing: const Icon(
                  //       Icons.arrow_forward_ios,
                  //       color: Colors.black,
                  //       size: 15,
                  //     )),
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
                              fontSize: 14, color: Colors.black)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      )),
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
                              fontSize: 14, color: Colors.black)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
