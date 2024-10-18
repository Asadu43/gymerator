import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/exercise_details_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../ui_component/exercise_detail_row.dart';
import '../../../../../../utils/nav/nav.dart';

class ExerciseScreen extends StatefulWidget {
  final List<Exercises> exercises;

  const ExerciseScreen({super.key, required this.exercises});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    Text("Exercise",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                      "Exercises (${widget.exercises.length.toString()})",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // Allow scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1),
                  // itemCount: allProduct?.data?.length ?? 0,
                  itemCount: widget.exercises.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Nav.push(
                            context,
                            ExerciseDetailsScreen(
                                exercise: widget.exercises[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  widget.exercises[index].exercise ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.vazirmatn(),
                                ),
                              ),
                              ExerciseDetailRow(
                                icon: "assets/icons/sets.png",
                                label: 'Sets',
                                value: widget.exercises[index].sets ?? "",
                              ),
                              ExerciseDetailRow(
                                icon: "assets/icons/time.png",
                                label: 'Rest Period',
                                value: widget.exercises[index].rest ?? "",
                              ),
                              ExerciseDetailRow(
                                icon: "assets/icons/rep.png",
                                label: 'Reps',
                                value: widget.exercises[index].reps ?? "",
                              ),
                              // ExerciseDetailRow(
                              //   icon: Icons.timer,
                              //   label: 'Duration',
                              //   value: widget.exercises[index].d,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
