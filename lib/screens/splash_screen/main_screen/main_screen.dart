import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/home_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;
  var _currentIndex = 0;

  final tabs = [
    const HomeScreen(),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: const Color(0xff599918),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title:  Text("Home",style: GoogleFonts.vazirmatn()),
              selectedColor: Colors.white,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title:  Text("Likes",style: GoogleFonts.vazirmatn()),
              selectedColor: Colors.white,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title:  Text("Search",style: GoogleFonts.vazirmatn()),
              selectedColor: Colors.white,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title:  Text("Profile",style: GoogleFonts.vazirmatn()),
              selectedColor: Colors.white,
            ),
          ],
        ),
        body: tabs[_currentIndex],

      ),
    );
  }
}
