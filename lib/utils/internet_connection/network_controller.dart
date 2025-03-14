import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(
      (event) {
        _updateConnectionStatus(event.first);
      },
    );
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // Get.dialog(AlertDialog(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20.0),
      //   ),
      //   backgroundColor: Colors.red,
      //
      //   icon: const Icon(Icons.add_alert),
      //   // surfaceTintColor: Colors.red,
      //   title: const Text(
      //     "Server Error",
      //     textAlign: TextAlign.center,
      //   ),
      //   titleTextStyle: GoogleFonts.vazirmatn(
      //       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.sp),
      //   content: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       "server is unavailable please try again in 20 seconds",
      //       textAlign: TextAlign.center,
      //       style: GoogleFonts.vazirmatn(color: Colors.white, fontSize: 12),
      //     ),
      //   ),
      //   contentTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
      //   actionsAlignment: MainAxisAlignment.center,
      //   actionsOverflowButtonSpacing: 8.0,
      //   actions: [],
      // ));
      Get.rawSnackbar(
          messageText: Text('PLEASE CONNECT TO THE INTERNET',
              style:
                  GoogleFonts.vazirmatn(color: Colors.white, fontSize: 12.sp)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
