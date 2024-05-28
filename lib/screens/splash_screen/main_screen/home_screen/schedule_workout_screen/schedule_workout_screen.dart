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

  Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Padding(
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
              child: Text("Today’s Report : ${weekdayName[DateTime.now().weekday]}",

                  style: GoogleFonts.vazirmatn(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),

            InkWell(
              onTap: () {
                Nav.push(context, const ExerciseScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(children: [
                      Image.asset("assets/images/dumbbells.png",fit: BoxFit.cover,),
                      SizedBox(width: screenWidth * 0.2),
                      Text("2 Dumbbells'",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 14.sp,
                              color: Colors.black)),

                    ],),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.12,

                decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(children: [
                    Image.asset("assets/images/cals.png",fit: BoxFit.cover,),
                    SizedBox(width: screenWidth * 0.2),
                    Text("340 Kal",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            color: Colors.black)),

                  ],),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.12,

                decoration: BoxDecoration(
                  // color: Colors.red,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(children: [
                    Image.asset("assets/images/achieved.png",fit: BoxFit.cover,),
                    SizedBox(width: screenWidth * 0.2),
                    Text("Achieved",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14.sp,
                            color: Colors.black)),

                  ],),
                ),
              ),
            )

          ],
        ),
      ),
    ));
  }
}




