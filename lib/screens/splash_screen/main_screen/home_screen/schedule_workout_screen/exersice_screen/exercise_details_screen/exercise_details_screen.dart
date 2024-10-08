import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../../ui_component/app_button.dart';
import '../../../../../../../utils/nav/nav.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final Exercises exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();

    // Create a VideoPlayerController for the video you want to play.
    _controller = VideoPlayerController.asset('assets/videos/video.mp4');

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
    return Scaffold(
      body: SafeArea(
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
                  SizedBox(width: screenWidth * 0.15),
                  Flexible(
                    child: Text(widget.exercise.exercise ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                height: screenHeight * 0.25,
                width: screenWidth,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(widget.exercise.exercise ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.vazirmatn(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bluetooth))
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 12.sp, color: Colors.black)),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screenHeight * 0.14,
                    width: screenWidth * 0.27,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1), // Border color and width
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image widget to display the clock image
                        Image.asset(
                          'assets/icons/clock.png', // Update with your asset image path
                        ),
                        const SizedBox(
                            height: 5), // Space between image and text
                        // Text widget to display the duration text
                        Text(
                          "Sets : ${widget.exercise.sets ?? ""}",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.14,
                    width: screenWidth * 0.27,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1), // Border color and width
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image widget to display the clock image
                        Image.asset(
                          'assets/icons/reps.png', // Update with your asset image path
                        ),
                        const SizedBox(
                            height: 8), // Space between image and text
                        // Text widget to display the duration text
                        Text(
                          "Reps : ${widget.exercise.reps ?? ""}",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.14,
                    width: screenWidth * 0.27,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1), // Border color and width
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image widget to display the clock image
                        Image.asset(
                          'assets/icons/rest.png', // Update with your asset image path
                        ),
                        const SizedBox(
                            height: 8), // Space between image and text
                        // Text widget to display the duration text
                        Text(
                          widget.exercise.rest ?? "",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 9.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                text: "Start Training",
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
