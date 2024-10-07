import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/generate_workout_plan_cubit/generate_work_out_plan_cubit.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/main_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/api_response/GenerateWorkoutPlanApiResponse.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../utils/nav/nav.dart';

class WorkoutPlanScreen extends StatefulWidget {
  const WorkoutPlanScreen({super.key});

  @override
  State<WorkoutPlanScreen> createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  GenerateWorkoutPlanApiResponse? response;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
          if (state is FailedToAcceptWorkoutPlan) {
            showSnackBar(
                context, state.response.message ?? "Failed to Accept Workout");
          }
          if (state is AcceptWorkoutPlanSuccessfully) {
            Nav.pushAndRemoveAllRoute(context, const MainScreen());
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
                            Text("Schedule Workout",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<GenerateWorkOutPlanCubit>()
                                      .generateWorkoutRequest();
                                },
                                icon: const Icon(Icons.refresh,
                                    color: Colors.black)),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.4,
                                    padding: const EdgeInsets.all(25),
                                    // color: Colors.red,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffE7F2DC)),
                                    child: Text(
                                      capitalizeFirstLetter(
                                          response?.data?[index].day ?? ""),
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  response?.data?[index].restDay == false
                                      ? Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: response?.data?[index]
                                                      .exercises?.length ??
                                                  0,
                                              itemBuilder: (context, ind) {
                                                return Column(
                                                  children: [
                                                    ExerciseTile(
                                                      exerciseName: response
                                                              ?.data?[index]
                                                              .exercises?[ind]
                                                              .exercise ??
                                                          "",
                                                      sets: response
                                                              ?.data?[index]
                                                              .exercises?[ind]
                                                              .sets ??
                                                          "" "",
                                                    ),
                                                    const Divider(),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                title: Text(
                                                  "Rest Day",
                                                  style:
                                                      GoogleFonts.vazirmatn(),
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
                          height: screenHeight * 0.02,
                        ),
                        state is LoadingState ? const SizedBox():AppButton(
                          text: "Accept Workout",
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
    var exercise = [];

    var ex = [];

    for(int i= 0; i< response!.data!.length; i++){

      // if(response!.data![i].exercises?.length == 0){


        print("Helllllllllllllllllll");
        for(int j= 0; j < (response?.data?[i].exercises?.length ?? 0); j++){

          Map dailyExercise = {
            "exercise": response?.data![i].exercises?[j].exercise,
            "sets": response?.data![i].exercises?[j].sets,
            "reps": response?.data![i].exercises?[j].reps,
            "rest": response?.data![i].exercises?[j].rest
          };
          ex.add(dailyExercise);

        // }
      }

      Map data = {
        "day": response?.data?[i].day,
        "exercises":ex,
        "rest_day": response?.data?[i].restDay
      };
      exercise.add(data);
    }



    print("exercise\n\n\n");
    print(exercise);
    print("\n\n\nexercise");
    // if (response!.data!.isEmpty) {
    //   showSnackBar(context, "Please generate again workout");
    // } else {
    //   context.read<GenerateWorkOutPlanCubit>().acceptWorkoutRequest(
    //     exercisePlan: response!.data!
    //       );
    // }
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
