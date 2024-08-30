import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/chat_screen/chat_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/home_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/profile_screen.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    const ChatScreen(),
    const ProductsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: const Color(0xff599918),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/home.png',
                width: 20,
                height: 20,
                color: _currentIndex == 0 ? Colors.white : Colors.black),
            title: Text("Home", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_chat_icon.png',
                width: 20,
                height: 20,
                color: _currentIndex == 1 ? Colors.white : Colors.black),
            title: Text("Chat Ai", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_products_icon.png',
                width: 20,
                height: 20,
                color: _currentIndex == 2 ? Colors.white : Colors.black),
            title: Text("Products", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_profile_icon.png',
                width: 20,
                height: 20,
                color: _currentIndex == 3 ? Colors.white : Colors.black),
            title: Text("Profile", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
