import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/home_screen/schedule_workout_screen/exersice_screen/exersice_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import 'package:sizer/sizer.dart';

class ScheduleWorkoutScreen extends StatefulWidget {
  const ScheduleWorkoutScreen({super.key});

  @override
  State<ScheduleWorkoutScreen> createState() => _ScheduleWorkoutScreenState();
}

class _ScheduleWorkoutScreenState extends State<ScheduleWorkoutScreen> {
  bool checkboxValue = false;
  int selectedIndex = 0;
  var selectedTime = '12.30';
  var selectedDate = 19;

  DateTime _selectedValue = DateTime.now();

  Map<int, String> weekdayName = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Nav.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text("Schedule Workout",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today_outlined)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              SizedBox(
                height: screenHeight * 0.13,
                child: DatePicker(
                  DateTime.now(),
                  daysCount: 7,
                  // inactiveDates: [
                  //   // DateTime.sunday,
                  // ],
                  initialSelectedDate: DateTime.now(),
                  selectionColor: const Color(0xff599918),
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const Divider(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                    "Today’s Report : ${weekdayName[DateTime.now().weekday]}",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Allow scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1.2),
                // itemCount: allProduct?.data?.length ?? 0,
                itemCount: 7,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Exercise information rows
                                ExerciseDetailRow(
                                  icon: Icons.fitness_center,
                                  label: 'Sets',
                                  value: '4',
                                ),
                                ExerciseDetailRow(
                                  icon: Icons.access_time,
                                  label: 'Rest Period',
                                  value: '1 min',
                                ),
                                ExerciseDetailRow(
                                  icon: Icons.timer,
                                  label: 'Duration',
                                  value: '30 mins',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 1,
                            left: 50,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Text(
                                'Monday',
                                style: GoogleFonts.vazirmatn(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ExerciseDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 10, color: Colors.black87),
          const SizedBox(width: 10),
          Text(
            '$label : ',
            style: GoogleFonts.vazirmatn(fontSize: 8.sp),
          ),
          Text(
            value,
            style: GoogleFonts.vazirmatn(fontSize: 8.sp),
          ),
        ],
      ),
    );
  }
}
