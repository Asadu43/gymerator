import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/resources/repository.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/chat_screen/chat_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/home_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/products_screen.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/profile_screen.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data);
  print("Message received in background: ${message.notification?.title}");
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;
  var _currentIndex = 0;
  Repository repository = Repository();

  final tabs = [
    const HomeScreen(),
    const ChatScreen(),
    const ProductsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeFCM();
    _setupFCMListeners();
  }

  /// **Initialize Firebase Messaging**
  Future<void> _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permissions (needed for iOS)
    NotificationSettings settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (Platform.isAndroid) {
        String? token = await messaging.getToken();
        if (token != null) {
          print("Android FCM Token: $token");
          repository.deviceRegisterRequest({"token": token, "deviceType": "android"});
        }
      } else if (Platform.isIOS) {
        String? apnsToken = await messaging.getAPNSToken();
        if (apnsToken != null) {
          print("iOS APNs Token: $apnsToken");
          repository.deviceRegisterRequest({"token": apnsToken, "deviceType": "ios"});
        }
      }
    }

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  /// **Listen for incoming notifications and handle them**
  void _setupFCMListeners() {
    // Handle notification when app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print(message.data);
      if (message.notification != null) {
        _showSnackBar(message.notification!.title ?? "New Notification");
      }
    });

    // Handle notification when app is opened by tapping a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message.data);

      if (message.notification != null) {
        _showSnackBar("App opened by notification: ${message.notification!.title}");
      }
    });
  }

  /// **Show a SnackBar for incoming notifications**
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: const Color(0xff599918),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/home.png', width: 20, height: 20, color: _currentIndex == 0 ? Colors.white : Colors.black),
            title: Text("Home", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_chat_icon.png', width: 20, height: 20, color: _currentIndex == 1 ? Colors.white : Colors.black),
            title: Text("GYMI", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_products_icon.png', width: 20, height: 20, color: _currentIndex == 2 ? Colors.white : Colors.black),
            title: Text("Products", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: Image.asset('assets/icons/main_screen_profile_icon.png', width: 20, height: 20, color: _currentIndex == 3 ? Colors.white : Colors.black),
            title: Text("Profile", style: GoogleFonts.vazirmatn()),
            selectedColor: Colors.white,
          ),
        ],
      ),
      body: tabs[_currentIndex],
    );
  }
}
