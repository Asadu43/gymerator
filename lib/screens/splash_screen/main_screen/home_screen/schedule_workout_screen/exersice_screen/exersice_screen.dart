import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/api_response/GetWorkoutPlanApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exercise_details_screen/exercise_details_screen.dart';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
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
                    SizedBox(width: 0.2.sw),
                    Text("Exercise",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 0.02.sh,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                      "Exercises (${widget.exercises.length.toString()})",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: 0.02.sh,
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
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical:16.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  widget.exercises[index].exercise ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.vazirmatn(fontSize: 12.sp,fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Divider(color: Colors.black),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 8.w),
                                child: Column(
                                  children: [
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
                                  ],
                                ),
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
