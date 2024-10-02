import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../utils/app_colors/app_colors.dart';

class UserIssueScreen extends StatefulWidget {
  const UserIssueScreen({super.key});

  @override
  State<UserIssueScreen> createState() => _UserIssueScreenState();
}

class _UserIssueScreenState extends State<UserIssueScreen> {
  String? selectMedical;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Replace with your image asset path
            fit: BoxFit.cover, // You can adjust the fit property as needed
          )),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenHeight / 14,
                ),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                Text("Do you have Medical issue?",
                    style: GoogleFonts.vazirmatn(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white)),
                Text(
                    "Your coach will filter and reduce inappropriate exercises for you  Used Password.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vazirmatn(
                        fontSize: 11.sp, color: Colors.grey)),
                SizedBox(
                  height: screenHeight * 0.030,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String? tempSelectedGoal = selectMedical;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Do you have any issue?',
                                  style:
                                      GoogleFonts.vazirmatn(fontSize: 14.sp)),
                              content: SizedBox(
                                width: screenWidth,
                                child: ListView(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('No,I’m fine',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'No,I’m fine',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Cardiovascular',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Cardiovascular',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Respiratory',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Respiratory',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Metabolic and Endocrine',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Metabolic and Endocrine',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Musculoskeletal',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Musculoskeletal',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Neurological',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Neurological',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Mental Health',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Mental Health',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Gastrointestinal',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Gastrointestinal',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Kidney and Liver',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Kidney and Liver',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Immune System',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Immune System',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Cancer',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Cancer',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Pregnancy and Postpartum',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Pregnancy and Postpartum',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Other Relevant',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Other Relevant',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              contentTextStyle:
                                  GoogleFonts.vazirmatn(color: Colors.black),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'CANCEL',
                                    style: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectMedical = tempSelectedGoal;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ).then(
                      (value) {
                        setState(() {
                          selectMedical;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectMedical == null
                            ? Text(
                                "Do you have any issue?",
                                style:
                                    GoogleFonts.vazirmatn(color: Colors.grey),
                              )
                            : Text(
                                "$selectMedical",
                                style:
                                    GoogleFonts.vazirmatn(color: Colors.white),
                              ),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String? tempSelectedGoal = selectMedical;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Do you have any issue?',
                                  style:
                                  GoogleFonts.vazirmatn(fontSize: 14.sp)),
                              content: SizedBox(
                                width: screenWidth,
                                child: ListView(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('No,I’m fine',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'No,I’m fine',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Cardiovascular',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Cardiovascular',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Respiratory',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Respiratory',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Metabolic and Endocrine',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Metabolic and Endocrine',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Musculoskeletal',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Musculoskeletal',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Neurological',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Neurological',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Mental Health',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Mental Health',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Gastrointestinal',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Gastrointestinal',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Kidney and Liver',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Kidney and Liver',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Immune System',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Immune System',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Cancer',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Cancer',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Pregnancy and Postpartum',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Pregnancy and Postpartum',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<String>(
                                      activeColor: const Color(0xff3F710D),
                                      title: Text('Other Relevant',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 10.sp)),
                                      value: 'Other Relevant',
                                      groupValue: tempSelectedGoal,
                                      onChanged: (String? value) {
                                        setState(() {
                                          tempSelectedGoal = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              contentTextStyle:
                              GoogleFonts.vazirmatn(color: Colors.black),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'CANCEL',
                                    style: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.vazirmatn(
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectMedical = tempSelectedGoal;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ).then(
                          (value) {
                        setState(() {
                          selectMedical;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectMedical == null
                            ? Text(
                          "Do you have any issue?",
                          style:
                          GoogleFonts.vazirmatn(color: Colors.grey),
                        )
                            : Text(
                          "$selectMedical",
                          style:
                          GoogleFonts.vazirmatn(color: Colors.white),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                AppButton(
                  text: "Submit",
                  onPressed: () async {
                    // Nav.push(context, const ChoosePlanScreen());
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
