import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/generate_workout_plan_cubit/generate_work_out_plan_cubit.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';

import '../../../../../../../bloC/auth_cubit/get_workout_plan_cubit/workout_plan_cubit.dart'
    hide LoadingState;
import '../../../../../../../models/api_response/GenerateWorkoutPlanApiResponse.dart';
import '../../../../../../../ui_component/app_button.dart';
import '../../../../../../../ui_component/exercise_detail_row.dart';
import '../../../../../../../utils/nav/nav.dart';

class UpdateWorkoutPlanScreen extends StatefulWidget {
  const UpdateWorkoutPlanScreen({super.key});

  @override
  State<UpdateWorkoutPlanScreen> createState() =>
      _UpdateWorkoutPlanScreenState();
}

class _UpdateWorkoutPlanScreenState extends State<UpdateWorkoutPlanScreen> {
  GenerateWorkoutPlanApiResponse? response;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenerateWorkOutPlanCubit()..generateWorkoutRequest(),
      child: BlocConsumer<GenerateWorkOutPlanCubit, GenerateWorkOutPlanState>(
        listener: (context, state) {
          if (state is FailedToGenerateWorkoutPlan) {
            showSnackBar(
                context, state.response.message ?? "Failed to generate plan");
          }
          if (state is GenerateWorkoutPlanSuccessfully) {
            response = state.response;
          }
          if (state is FailedToUpdateWorkoutPlan) {
            showSnackBar(context,
                state.response.message ?? "Failed to Update Workout Plan");
          }
          if (state is UpdateWorkoutPlanSuccessfully) {
            showSnackBar(
                context,
                state.response.message ??
                    "Your Workout plan Update successfully",
                type: SnackBarType.success);
            context.read<WorkoutPlanCubit>().getWorkoutRequest();
            Nav.pop(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Nav.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios)),
                            // SizedBox(width: screenWidth * 0.2),
                            Text("Update Workout",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                           const SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        ListView.builder(
                          itemCount: response?.data?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              color: const Color(0xffE7F2DC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 0.4.sw, // Responsive width
                                    padding: EdgeInsets.all(25.w), // Responsive padding
                                    decoration: const BoxDecoration(
                                        color: Color(0xffE7F2DC)),
                                    child: Text(
                                      capitalizeFirstLetter(
                                          response?.data?[index].day ?? ""),
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  response?.data?[index].restDay == false
                                      ? Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const Divider();
                                        },
                                        shrinkWrap: true,
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        itemCount: response?.data?[index]
                                            .exercises?.length ??
                                            0,
                                        itemBuilder: (context, ind) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.0.w,
                                              vertical: 8.0.h,
                                            ), // Responsive padding
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    response
                                                        ?.data?[index]
                                                        .exercises?[ind]
                                                        .exercise ??
                                                        "",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.vazirmatn(fontSize: 12.sp,fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                                ExerciseDetailRow(
                                                  icon: "assets/icons/sets.png",
                                                  label: 'Sets',
                                                  value: response
                                                      ?.data?[index]
                                                      .exercises?[ind]
                                                      .sets ??
                                                      "",
                                                ),
                                                ExerciseDetailRow(
                                                  icon: "assets/icons/rep.png",
                                                  label: 'Reps',
                                                  value: response
                                                      ?.data?[index]
                                                      .exercises?[ind]
                                                      .reps ??
                                                      "",
                                                ),
                                                ExerciseDetailRow(
                                                  icon: "assets/icons/time.png",
                                                  label: 'Rest Period',
                                                  value: response
                                                      ?.data?[index]
                                                      .exercises?[ind]
                                                      .rest ??
                                                      "",
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                      : Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.w), // Responsive padding
                                        child: ListTile(
                                          title: Text(
                                            "Rest Day",
                                            style: GoogleFonts.vazirmatn(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 0.02.sh,
                        ),
                        state is LoadingState
                            ? const SizedBox()
                            : AppButton(
                                text: "Regenerate Workout Plan",
                                onPressed: () async {
                                  context
                                      .read<GenerateWorkOutPlanCubit>()
                                      .generateWorkoutRequest();
                                },
                              ),

                        SizedBox(
                          height: 0.02.sh,
                        ),
                        state is LoadingState
                            ? const SizedBox()
                            : AppButton(
                          text: "Update Workout Plan",
                          onPressed: () async {
                            await _onAcceptButtonPressed(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onAcceptButtonPressed(BuildContext context) async {
    if (response!.data!.isEmpty) {
      showSnackBar(context, "Please generate again workout");
    } else {
      context.read<GenerateWorkOutPlanCubit>().updateWorkoutRequest();
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String sets;

  const ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.sets,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        exerciseName,
        style: GoogleFonts.vazirmatn(fontSize: 12.sp),
      ),
      subtitle:
          Text('Sets: $sets', style: GoogleFonts.vazirmatn(fontSize: 10.sp)),
    );
  }
}
