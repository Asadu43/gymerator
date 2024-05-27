import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/nft_market_place_screen/nft_market_place_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/wallet_screen/wallet_screen.dart';
import 'package:gymmerator/screens/splash_screen/metamask_screen/metamask_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Asad Ullah"),
              accountEmail: Text("au4098@gmail.com"),
              decoration: BoxDecoration(
                color: Color(0xff599918),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/traning.png'),
              ),
            ),
            ListTile(
                onTap: () {
                  Nav.push(context, const NftMarketPlaceScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: Image.asset("assets/icons/nft.png"),
                ),
                title: Text("NFT Marketplace",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 14, color: Colors.black)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                )),
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
            ListTile(
                onTap: () {
                  Nav.push(context, const WalletScreen());
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 25,
                  child: Image.asset("assets/icons/wallet.png"),
                ),
                title: Text("Wallet",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 14, color: Colors.black)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 15,
                )),
            ListTile(
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
    );
  }
}
