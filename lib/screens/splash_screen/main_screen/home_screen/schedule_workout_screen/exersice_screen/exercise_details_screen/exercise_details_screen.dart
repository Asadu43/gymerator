
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../ui_component/app_button.dart';
import '../../../../../../../utils/nav/nav.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  const ExerciseDetailsScreen({super.key});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {

  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // Create a VideoPlayerController for the video you want to play.
    _controller = VideoPlayerController.asset(
        'assets/videos/video.mp4');

    // Initialize the VideoPlayerController.
    _controller!.initialize();

    // Play the video.
    _controller!.play();

  }

  @override
  void dispose() {
    super.dispose();

    // Dispose of the VideoPlayerController.
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Nav.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(width: screenWidth * 0.2),
                  Text("Interval pilates",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),

              Container(
                height: screenHeight * 0.25,
                width:  screenWidth ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Interval pilates",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  IconButton(onPressed: () {

                  }, icon: const Icon(Icons.bluetooth))
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 12.sp,
                      color: Colors.black)),
              SizedBox(height: screenHeight * 0.3),
              AppButton(
                text: "Start Training",
                onPressed: () async {
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
