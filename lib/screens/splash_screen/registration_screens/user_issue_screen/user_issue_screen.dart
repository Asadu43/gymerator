import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/choose_plan_screen/choose_plan_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';
import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/show_snackbar.dart';
import '../../../../utils/app_colors/app_colors.dart';

class UserIssueScreen extends StatefulWidget {
  final String gender;
  final String heightUnit;
  final double heightValue;
  final String weightUnit;
  final double weightValue;
  final String age;
  final int goal;
  final String sleepHours;
  final String mealFrequency;
  final String hydrationDaily;
  final String targetWeight;
  final int dietPlan;

  const UserIssueScreen(
      {super.key,
      required this.gender,
      required this.heightUnit,
      required this.heightValue,
      required this.weightUnit,
      required this.weightValue,
      required this.age,
      required this.goal,
      required this.sleepHours,
      required this.mealFrequency,
      required this.hydrationDaily,
      required this.targetWeight,
      required this.dietPlan});

  @override
  State<UserIssueScreen> createState() => _UserIssueScreenState();
}

class _UserIssueScreenState extends State<UserIssueScreen> {
  String? selectMedicalName;
  String? medicalCondition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          // Replace with your image asset path
          fit: BoxFit.cover, // You can adjust the fit property as needed
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 1.sh / 12,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text("Do you have Medical issue?",
                  style: GoogleFonts.vazirmatn(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white)),
              SizedBox(
                height: 10.h,
              ),
              Text(
                  "Your coach will filter and reduce inappropriate exercises for you",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vazirmatn(
                      fontSize: 16.sp, color: Colors.grey)),
              SizedBox(
                height: 50.h,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      String? tempSelectedGoal = selectMedicalName;

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            shape:  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            title: Text('Do you have any issue?',
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            content: SizedBox(
                              width: 1.sw,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  RadioListTile<String>(
                                    activeColor: const Color(0xff3F710D),
                                    title: Text('No,I’m fine',
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 14.sp)),
                                    value: 'No,I’m fine',
                                    groupValue: tempSelectedGoal,
                                    onChanged: (String? value) {
                                      setState(() {
                                        tempSelectedGoal = value!;
                                        medicalCondition = null;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    activeColor: const Color(0xff3F710D),
                                    title: Text('Cardiovascular',
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                            fontSize: 14.sp)),
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
                                  'Cancel',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 14.sp, color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Ok',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 14.sp, color: Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectMedicalName = tempSelectedGoal;
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
                        selectMedicalName;
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
                      selectMedicalName == null
                          ? Text(
                              "Do you have any issue?",
                              style: GoogleFonts.vazirmatn(color: Colors.grey),
                            )
                          : Text(
                              "$selectMedicalName",
                              style: GoogleFonts.vazirmatn(color: Colors.white),
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
                height: 20.h,
              ),
              (selectMedicalName == null || selectMedicalName == "No,I’m fine")
                  ? const SizedBox()
                  : selectMedicalName == "Cardiovascular"
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                String? tempSelectedGoal = medicalCondition;

                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      shape:  RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r))),
                                      title: Text('Cardiovascular Conditions',
                                          style: GoogleFonts.vazirmatn(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold)),
                                      content: SizedBox(
                                        width: 1.sw,
                                        child: ListView(
                                          shrinkWrap: true,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RadioListTile<String>(
                                              activeColor:
                                                  const Color(0xff3F710D),
                                              title: Text('Heart Disease',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 14.sp)),
                                              value: 'Heart Disease',
                                              groupValue: tempSelectedGoal,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  tempSelectedGoal = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile<String>(
                                              activeColor:
                                                  const Color(0xff3F710D),
                                              title: Text('High Blood Pressure',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 14.sp)),
                                              value: 'High Blood Pressure',
                                              groupValue: tempSelectedGoal,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  tempSelectedGoal = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile<String>(
                                              activeColor:
                                                  const Color(0xff3F710D),
                                              title: Text('Low Blood Pressure',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 14.sp)),
                                              value: 'Low Blood Pressure',
                                              groupValue: tempSelectedGoal,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  tempSelectedGoal = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile<String>(
                                              activeColor:
                                                  const Color(0xff3F710D),
                                              title: Text('Arrhythmias',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 14.sp)),
                                              value: 'Arrhythmias',
                                              groupValue: tempSelectedGoal,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  tempSelectedGoal = value!;
                                                });
                                              },
                                            ),
                                            RadioListTile<String>(
                                              activeColor:
                                                  const Color(0xff3F710D),
                                              title: Text(
                                                  'Peripheral Artery Disease',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 14.sp)),
                                              value:
                                                  'Peripheral Artery Disease',
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
                                      contentTextStyle: GoogleFonts.vazirmatn(
                                          color: Colors.black),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.vazirmatn(
                                                color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'OK',
                                            style: GoogleFonts.vazirmatn(
                                                fontSize: 14.sp,
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              medicalCondition =
                                                  tempSelectedGoal;
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
                                  medicalCondition;
                                });
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.07,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                medicalCondition == null
                                    ? Text(
                                        "Please select condition",
                                        style: GoogleFonts.vazirmatn(
                                            color: Colors.grey),
                                      )
                                    : Text(
                                        "$medicalCondition",
                                        style: GoogleFonts.vazirmatn(
                                            color: Colors.white),
                                      ),
                                const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        )
                      : selectMedicalName == "Respiratory"
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    String? tempSelectedGoal = medicalCondition;

                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          shape:  RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.r))),
                                          title: Text('Respiratory Conditions',
                                              style: GoogleFonts.vazirmatn(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold)),
                                          content: SizedBox(
                                            width: 1.sw,
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                RadioListTile<String>(
                                                  activeColor:
                                                      const Color(0xff3F710D),
                                                  title: Text('Asthma',
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                              fontSize: 14.sp)),
                                                  value: 'Asthma',
                                                  groupValue: tempSelectedGoal,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      tempSelectedGoal = value!;
                                                    });
                                                  },
                                                ),
                                                RadioListTile<String>(
                                                  activeColor:
                                                      const Color(0xff3F710D),
                                                  title: Text(
                                                      'Chronic Obstructive Pulmonary Disease',
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                              fontSize: 14.sp)),
                                                  value:
                                                      'Chronic Obstructive Pulmonary Disease',
                                                  groupValue: tempSelectedGoal,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      tempSelectedGoal = value!;
                                                    });
                                                  },
                                                ),
                                                RadioListTile<String>(
                                                  activeColor:
                                                      const Color(0xff3F710D),
                                                  title: Text('Sleep Apnea',
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                              fontSize: 14.sp)),
                                                  value: 'Sleep Apnea',
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
                                              GoogleFonts.vazirmatn(
                                                  color: Colors.black),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp,
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'OK',
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 14.sp,
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  medicalCondition =
                                                      tempSelectedGoal;
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
                                      medicalCondition;
                                    });
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    medicalCondition == null
                                        ? Text(
                                            "Please select condition",
                                            style: GoogleFonts.vazirmatn(
                                                color: Colors.grey),
                                          )
                                        : Text(
                                            "$medicalCondition",
                                            style: GoogleFonts.vazirmatn(
                                                color: Colors.white),
                                          ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : selectMedicalName == "Musculoskeletal"
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        String? tempSelectedGoal =
                                            medicalCondition;

                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return AlertDialog(
                                              shape:
                                                   RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.r))),
                                              title: Text(
                                                  'Musculoskeletal Conditions',
                                                  style: GoogleFonts.vazirmatn(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              content: SizedBox(
                                                width: 1.sw,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text('Arthritis',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Arthritis',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text(
                                                          'Osteoporosis',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Osteoporosis',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text(
                                                          'Chronic Back Pain',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value:
                                                          'Chronic Back Pain',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text(
                                                          'Joint Injuries',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Joint Injuries',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text(
                                                          'Fibromyalgia',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Fibromyalgia',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text('Tendinitis',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Tendinitis',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile<String>(
                                                      activeColor: const Color(
                                                          0xff3F710D),
                                                      title: Text('Bursitis',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      14.sp)),
                                                      value: 'Bursitis',
                                                      groupValue:
                                                          tempSelectedGoal,
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          tempSelectedGoal =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              contentTextStyle:
                                                  GoogleFonts.vazirmatn(
                                                      color: Colors.black),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    'Cancel',
                                                    style:
                                                        GoogleFonts.vazirmatn(
                                                            fontSize: 14.sp,
                                                            color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    'OK',
                                                    style:
                                                        GoogleFonts.vazirmatn(
                                                            fontSize: 14.sp,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      medicalCondition =
                                                          tempSelectedGoal;
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
                                          medicalCondition;
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        medicalCondition == null
                                            ? Text(
                                                "Please select condition",
                                                style: GoogleFonts.vazirmatn(
                                                    color: Colors.grey),
                                              )
                                            : Text(
                                                "$medicalCondition",
                                                style: GoogleFonts.vazirmatn(
                                                    color: Colors.white),
                                              ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : selectMedicalName == "Neurological"
                                  ? InkWell(
                                      onTap: () {
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            String? tempSelectedGoal =
                                                medicalCondition;
                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  shape:
                                                       RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.r))),
                                                  title: Text(
                                                      'Neurological Conditions',
                                                      style:
                                                          GoogleFonts.vazirmatn(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  content: SizedBox(
                                                    width: 1.sw,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      children: [
                                                        RadioListTile<String>(
                                                          activeColor:
                                                              const Color(
                                                                  0xff3F710D),
                                                          title: Text(
                                                              'Parkinson Disease',
                                                              style: GoogleFonts
                                                                  .vazirmatn(
                                                                      fontSize:
                                                                          14.sp)),
                                                          value:
                                                              'Parkinson Disease',
                                                          groupValue:
                                                              tempSelectedGoal,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              tempSelectedGoal =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                        RadioListTile<String>(
                                                          activeColor:
                                                              const Color(
                                                                  0xff3F710D),
                                                          title: Text(
                                                              'Multiple Sclerosis',
                                                              style: GoogleFonts
                                                                  .vazirmatn(
                                                                      fontSize:
                                                                          14.sp)),
                                                          value:
                                                              'Multiple Sclerosis',
                                                          groupValue:
                                                              tempSelectedGoal,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              tempSelectedGoal =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                        RadioListTile<String>(
                                                          activeColor:
                                                              const Color(
                                                                  0xff3F710D),
                                                          title: Text(
                                                              'Epilepsy',
                                                              style: GoogleFonts
                                                                  .vazirmatn(
                                                                      fontSize:
                                                                          14.sp)),
                                                          value: 'Epilepsy',
                                                          groupValue:
                                                              tempSelectedGoal,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              tempSelectedGoal =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                        RadioListTile<String>(
                                                          activeColor:
                                                              const Color(
                                                                  0xff3F710D),
                                                          title: Text(
                                                              'Stroke History',
                                                              style: GoogleFonts
                                                                  .vazirmatn(
                                                                      fontSize:
                                                                          14.sp)),
                                                          value:
                                                              'Stroke History',
                                                          groupValue:
                                                              tempSelectedGoal,
                                                          onChanged:
                                                              (String? value) {
                                                            setState(() {
                                                              tempSelectedGoal =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  contentTextStyle:
                                                      GoogleFonts.vazirmatn(
                                                          color: Colors.black),
                                                  actions: [
                                                    TextButton(
                                                      child: Text(
                                                        'Cancel',
                                                        style: GoogleFonts
                                                            .vazirmatn(
                                                                fontSize: 14.sp,
                                                                color:
                                                                    Colors.red),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                        'OK',
                                                        style: GoogleFonts
                                                            .vazirmatn(
                                                                fontSize: 14.sp,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          medicalCondition =
                                                              tempSelectedGoal;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
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
                                              medicalCondition;
                                            });
                                          },
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            medicalCondition == null
                                                ? Text(
                                                    "Please select condition",
                                                    style:
                                                        GoogleFonts.vazirmatn(
                                                            color: Colors.grey),
                                                  )
                                                : Text(
                                                    "$medicalCondition",
                                                    style:
                                                        GoogleFonts.vazirmatn(
                                                            color:
                                                                Colors.white),
                                                  ),
                                            const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : selectMedicalName == "Mental Health"
                                      ? InkWell(
                                          onTap: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                String? tempSelectedGoal =
                                                    medicalCondition;

                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return AlertDialog(
                                                      shape:  RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.r))),
                                                      title: Text(
                                                          'Mental Health Conditions',
                                                          style: GoogleFonts
                                                              .vazirmatn(
                                                                  fontSize:
                                                                      20.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      content: SizedBox(
                                                        width: 1.sw,
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: [
                                                            RadioListTile<
                                                                String>(
                                                              activeColor:
                                                                  const Color(
                                                                      0xff3F710D),
                                                              title: Text(
                                                                  'Depression',
                                                                  style: GoogleFonts
                                                                      .vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                              value:
                                                                  'Depression',
                                                              groupValue:
                                                                  tempSelectedGoal,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                setState(() {
                                                                  tempSelectedGoal =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                String>(
                                                              activeColor:
                                                                  const Color(
                                                                      0xff3F710D),
                                                              title: Text(
                                                                  'Anxiety Disorders',
                                                                  style: GoogleFonts
                                                                      .vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                              value:
                                                                  'Anxiety Disorders',
                                                              groupValue:
                                                                  tempSelectedGoal,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                setState(() {
                                                                  tempSelectedGoal =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                String>(
                                                              activeColor:
                                                                  const Color(
                                                                      0xff3F710D),
                                                              title: Text(
                                                                  'Bipolar Disorder',
                                                                  style: GoogleFonts
                                                                      .vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                              value:
                                                                  'Bipolar Disorder',
                                                              groupValue:
                                                                  tempSelectedGoal,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                setState(() {
                                                                  tempSelectedGoal =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile<
                                                                String>(
                                                              activeColor:
                                                                  const Color(
                                                                      0xff3F710D),
                                                              title: Text(
                                                                  'Post-Traumatic Stress Disorder',
                                                                  style: GoogleFonts
                                                                      .vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                              value:
                                                                  'Post-Traumatic Stress Disorder',
                                                              groupValue:
                                                                  tempSelectedGoal,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                setState(() {
                                                                  tempSelectedGoal =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      contentTextStyle:
                                                          GoogleFonts.vazirmatn(
                                                              color:
                                                                  Colors.black),
                                                      actions: [
                                                        TextButton(
                                                          child: Text(
                                                            'Cancel',
                                                            style: GoogleFonts
                                                                .vazirmatn(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text(
                                                            'Ok',
                                                            style: GoogleFonts
                                                                .vazirmatn(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              medicalCondition =
                                                                  tempSelectedGoal;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                                  medicalCondition;
                                                });
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 16),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                medicalCondition == null
                                                    ? Text(
                                                        "Please select condition",
                                                        style: GoogleFonts
                                                            .vazirmatn(
                                                                color: Colors
                                                                    .grey),
                                                      )
                                                    : Text(
                                                        "$medicalCondition",
                                                        style: GoogleFonts
                                                            .vazirmatn(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_sharp,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : selectMedicalName == "Gastrointestinal"
                                          ? InkWell(
                                              onTap: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    String? tempSelectedGoal =
                                                        medicalCondition;

                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                        return AlertDialog(
                                                          shape:  RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.r))),
                                                          title: Text(
                                                              'Gastrointestinal Conditions',
                                                              style: GoogleFonts
                                                                  .vazirmatn(
                                                                      fontSize:
                                                                          20.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                          content: SizedBox(
                                                            width: 1.sw,
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                RadioListTile<
                                                                    String>(
                                                                  activeColor:
                                                                      const Color(
                                                                          0xff3F710D),
                                                                  title: Text(
                                                                      'Irritable Bowel Syndrome',
                                                                      style: GoogleFonts.vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                                  value:
                                                                      'Irritable Bowel Syndrome',
                                                                  groupValue:
                                                                      tempSelectedGoal,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      tempSelectedGoal =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                                RadioListTile<
                                                                    String>(
                                                                  activeColor:
                                                                      const Color(
                                                                          0xff3F710D),
                                                                  title: Text(
                                                                      'Gastro esophageal Reflux Disease',
                                                                      style: GoogleFonts.vazirmatn(
                                                                          fontSize:
                                                                              14.sp)),
                                                                  value:
                                                                      'Gastro esophageal Reflux Disease',
                                                                  groupValue:
                                                                      tempSelectedGoal,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      tempSelectedGoal =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          contentTextStyle:
                                                              GoogleFonts.vazirmatn(
                                                                  color: Colors
                                                                      .black),
                                                          actions: [
                                                            TextButton(
                                                              child: Text(
                                                                'Cancel',
                                                                style: GoogleFonts
                                                                    .vazirmatn(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                'Ok',
                                                                style: GoogleFonts.vazirmatn(
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  medicalCondition =
                                                                      tempSelectedGoal;
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                                                      medicalCondition;
                                                    });
                                                  },
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 16),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    medicalCondition == null
                                                        ? Text(
                                                            "Please select condition",
                                                            style: GoogleFonts
                                                                .vazirmatn(
                                                                    color: Colors
                                                                        .grey),
                                                          )
                                                        : Text(
                                                            "$medicalCondition",
                                                            style: GoogleFonts
                                                                .vazirmatn(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                    const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_sharp,
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : selectMedicalName ==
                                                  "Kidney and Liver"
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        String?
                                                            tempSelectedGoal =
                                                            medicalCondition;

                                                        return StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                            return AlertDialog(
                                                              shape:  RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.r))),
                                                              title: Text(
                                                                  'Kidney and Liver Conditions',
                                                                  style: GoogleFonts.vazirmatn(
                                                                      fontSize:
                                                                          20.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              content: SizedBox(
                                                                width: 1.sw,
                                                                child: ListView(
                                                                  shrinkWrap:
                                                                      true,
                                                                  children: [
                                                                    RadioListTile<
                                                                        String>(
                                                                      activeColor:
                                                                          const Color(
                                                                              0xff3F710D),
                                                                      title: Text(
                                                                          'Chronic Kidney Disease',
                                                                          style:
                                                                              GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                      value:
                                                                          'Chronic Kidney Disease',
                                                                      groupValue:
                                                                          tempSelectedGoal,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          tempSelectedGoal =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                    RadioListTile<
                                                                        String>(
                                                                      activeColor:
                                                                          const Color(
                                                                              0xff3F710D),
                                                                      title: Text(
                                                                          'Liver Disease',
                                                                          style:
                                                                              GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                      value:
                                                                          'Liver Disease',
                                                                      groupValue:
                                                                          tempSelectedGoal,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          tempSelectedGoal =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              contentTextStyle:
                                                                  GoogleFonts.vazirmatn(
                                                                      color: Colors
                                                                          .black),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                    'Cancel',
                                                                    style: GoogleFonts.vazirmatn(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                TextButton(
                                                                  child: Text(
                                                                    'Ok',
                                                                    style: GoogleFonts.vazirmatn(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      medicalCondition =
                                                                          tempSelectedGoal;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
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
                                                          medicalCondition;
                                                        });
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 4,
                                                        horizontal: 16),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        medicalCondition == null
                                                            ? Text(
                                                                "Please select condition",
                                                                style: GoogleFonts
                                                                    .vazirmatn(
                                                                        color: Colors
                                                                            .grey),
                                                              )
                                                            : Text(
                                                                "$medicalCondition",
                                                                style: GoogleFonts
                                                                    .vazirmatn(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                        const Icon(
                                                          Icons
                                                              .keyboard_arrow_down_sharp,
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : selectMedicalName ==
                                                      "Immune System"
                                                  ? InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            String?
                                                                tempSelectedGoal =
                                                                medicalCondition;

                                                            return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                                return AlertDialog(
                                                                  shape:  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10.r))),
                                                                  title: Text(
                                                                      'Immune System Conditions',
                                                                      style: GoogleFonts.vazirmatn(
                                                                          fontSize: 20
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  content:
                                                                      SizedBox(
                                                                    width: 1.sw,
                                                                    child:
                                                                        ListView(
                                                                      shrinkWrap:
                                                                          true,
                                                                      children: [
                                                                        RadioListTile<
                                                                            String>(
                                                                          activeColor:
                                                                              const Color(0xff3F710D),
                                                                          title: Text(
                                                                              'Chronic Kidney Disease',
                                                                              style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                          value:
                                                                              'Chronic Kidney Disease',
                                                                          groupValue:
                                                                              tempSelectedGoal,
                                                                          onChanged:
                                                                              (String? value) {
                                                                            setState(() {
                                                                              tempSelectedGoal = value!;
                                                                            });
                                                                          },
                                                                        ),
                                                                        RadioListTile<
                                                                            String>(
                                                                          activeColor:
                                                                              const Color(0xff3F710D),
                                                                          title: Text(
                                                                              'HIV/AIDS',
                                                                              style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                          value:
                                                                              'HIV/AIDS',
                                                                          groupValue:
                                                                              tempSelectedGoal,
                                                                          onChanged:
                                                                              (String? value) {
                                                                            setState(() {
                                                                              tempSelectedGoal = value!;
                                                                            });
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  contentTextStyle:
                                                                      GoogleFonts.vazirmatn(
                                                                          color:
                                                                              Colors.black),
                                                                  actions: [
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        'Cancel',
                                                                        style: GoogleFonts.vazirmatn(
                                                                            color:
                                                                                Colors.red,
                                                                            fontSize: 14.sp),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        'Ok',
                                                                        style: GoogleFonts.vazirmatn(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 14.sp),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          medicalCondition =
                                                                              tempSelectedGoal;
                                                                        });
                                                                        Navigator.of(context)
                                                                            .pop();
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
                                                              medicalCondition;
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 4,
                                                                horizontal: 16),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            medicalCondition ==
                                                                    null
                                                                ? Text(
                                                                    "Please select condition",
                                                                    style: GoogleFonts
                                                                        .vazirmatn(
                                                                            color:
                                                                                Colors.grey),
                                                                  )
                                                                : Text(
                                                                    "$medicalCondition",
                                                                    style: GoogleFonts
                                                                        .vazirmatn(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                            const Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_sharp,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : selectMedicalName ==
                                                          "Cancer"
                                                      ? InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                String?
                                                                    tempSelectedGoal =
                                                                    medicalCondition;

                                                                return StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                    return AlertDialog(
                                                                      shape:  RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10.r))),
                                                                      title: Text(
                                                                          'Cancer',
                                                                          style: GoogleFonts.vazirmatn(
                                                                              fontSize: 20.sp,
                                                                              fontWeight: FontWeight.bold)),
                                                                      content:
                                                                          SizedBox(
                                                                        width: 1
                                                                            .sw,
                                                                        child:
                                                                            ListView(
                                                                          shrinkWrap:
                                                                              true,
                                                                          children: [
                                                                            RadioListTile<String>(
                                                                              activeColor: const Color(0xff3F710D),
                                                                              title: Text('History of Cancer', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                              value: 'History of Cancer',
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
                                                                          GoogleFonts.vazirmatn(
                                                                              color: Colors.black),
                                                                      actions: [
                                                                        TextButton(
                                                                          child:
                                                                              Text(
                                                                            'Cancel',
                                                                            style:
                                                                                GoogleFonts.vazirmatn(color: Colors.red, fontSize: 14.sp),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              Text(
                                                                            'Ok',
                                                                            style:
                                                                                GoogleFonts.vazirmatn(color: Colors.black, fontSize: 14.sp),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              medicalCondition = tempSelectedGoal;
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
                                                                  medicalCondition;
                                                                });
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.07,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        16),
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                medicalCondition ==
                                                                        null
                                                                    ? Text(
                                                                        "Please select condition",
                                                                        style: GoogleFonts.vazirmatn(
                                                                            color:
                                                                                Colors.grey),
                                                                      )
                                                                    : Text(
                                                                        "$medicalCondition",
                                                                        style: GoogleFonts.vazirmatn(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_sharp,
                                                                  color: Colors
                                                                      .grey,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : selectMedicalName ==
                                                              "Pregnancy and Postpartum"
                                                          ? InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                  barrierDismissible:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    String?
                                                                        tempSelectedGoal =
                                                                        medicalCondition;

                                                                    return StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                        return AlertDialog(
                                                                          shape:
                                                                               RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
                                                                          title: Text(
                                                                              'Pregnancy and Postpartum',
                                                                              style: GoogleFonts.vazirmatn(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                                                          content:
                                                                              SizedBox(
                                                                            width:
                                                                                1.sw,
                                                                            child:
                                                                                ListView(
                                                                              shrinkWrap: true,
                                                                              children: [
                                                                                RadioListTile<String>(
                                                                                  activeColor: const Color(0xff3F710D),
                                                                                  title: Text('Currently Pregnant', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                  value: 'Currently Pregnant',
                                                                                  groupValue: tempSelectedGoal,
                                                                                  onChanged: (String? value) {
                                                                                    setState(() {
                                                                                      tempSelectedGoal = value!;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                RadioListTile<String>(
                                                                                  activeColor: const Color(0xff3F710D),
                                                                                  title: Text('Postpartum Recovery', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                  value: 'Postpartum Recovery',
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
                                                                                'Cancel',
                                                                                style: GoogleFonts.vazirmatn(color: Colors.red, fontSize: 14.sp),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                            TextButton(
                                                                              child: Text(
                                                                                'Ok',
                                                                                style: GoogleFonts.vazirmatn(color: Colors.black, fontSize: 14.sp),
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  medicalCondition = tempSelectedGoal;
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
                                                                    setState(
                                                                        () {
                                                                      medicalCondition;
                                                                    });
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.07,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        16),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    medicalCondition ==
                                                                            null
                                                                        ? Text(
                                                                            "Please select condition",
                                                                            style:
                                                                                GoogleFonts.vazirmatn(color: Colors.grey),
                                                                          )
                                                                        : Text(
                                                                            "$medicalCondition",
                                                                            style:
                                                                                GoogleFonts.vazirmatn(color: Colors.white),
                                                                          ),
                                                                    const Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_sharp,
                                                                      color: Colors
                                                                          .grey,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : selectMedicalName ==
                                                                  "Other Relevant"
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      barrierDismissible:
                                                                          false,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        String?
                                                                            tempSelectedGoal =
                                                                            medicalCondition;

                                                                        return StatefulBuilder(
                                                                          builder:
                                                                              (context, setState) {
                                                                            return AlertDialog(
                                                                              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
                                                                              title: Text('Other Relevant Conditions', style: GoogleFonts.vazirmatn(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                                                              content: SizedBox(
                                                                                width: 1.sw,
                                                                                child: ListView(
                                                                                  shrinkWrap: true,
                                                                                  children: [
                                                                                    RadioListTile<String>(
                                                                                      activeColor: const Color(0xff3F710D),
                                                                                      title: Text('Obesity', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                      value: 'Obesity',
                                                                                      groupValue: tempSelectedGoal,
                                                                                      onChanged: (String? value) {
                                                                                        setState(() {
                                                                                          tempSelectedGoal = value!;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    RadioListTile<String>(
                                                                                      activeColor: const Color(0xff3F710D),
                                                                                      title: Text('Eating Disorders', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                      value: 'Eating Disorders',
                                                                                      groupValue: tempSelectedGoal,
                                                                                      onChanged: (String? value) {
                                                                                        setState(() {
                                                                                          tempSelectedGoal = value!;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    RadioListTile<String>(
                                                                                      activeColor: const Color(0xff3F710D),
                                                                                      title: Text('Chronic Fatigue Syndrome', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                      value: 'Chronic Fatigue Syndrome',
                                                                                      groupValue: tempSelectedGoal,
                                                                                      onChanged: (String? value) {
                                                                                        setState(() {
                                                                                          tempSelectedGoal = value!;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    RadioListTile<String>(
                                                                                      activeColor: const Color(0xff3F710D),
                                                                                      title: Text('Blood Clotting Disorders', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                      value: 'Blood Clotting Disorders',
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
                                                                              contentTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                                                                              actions: [
                                                                                TextButton(
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: GoogleFonts.vazirmatn(color: Colors.red, fontSize: 14.sp),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                                TextButton(
                                                                                  child: Text(
                                                                                    'Ok',
                                                                                    style: GoogleFonts.vazirmatn(color: Colors.black, fontSize: 14.sp),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    setState(() {
                                                                                      medicalCondition = tempSelectedGoal;
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
                                                                        setState(
                                                                            () {
                                                                          medicalCondition;
                                                                        });
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.07,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            4,
                                                                        horizontal:
                                                                            16),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        medicalCondition ==
                                                                                null
                                                                            ? Text(
                                                                                "Please select condition",
                                                                                style: GoogleFonts.vazirmatn(color: Colors.grey),
                                                                              )
                                                                            : Text(
                                                                                "$medicalCondition",
                                                                                style: GoogleFonts.vazirmatn(color: Colors.white),
                                                                              ),
                                                                        const Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_sharp,
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : selectMedicalName ==
                                                                      "Metabolic and Endocrine"
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            String?
                                                                                tempSelectedGoal =
                                                                                medicalCondition;

                                                                            return StatefulBuilder(
                                                                              builder: (context, setState) {
                                                                                return AlertDialog(
                                                                                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
                                                                                  title: Text('Metabolic and Endocrine Conditions', style: GoogleFonts.vazirmatn(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                                                                  content: SizedBox(
                                                                                    width: 1.sw,
                                                                                    child: ListView(
                                                                                      shrinkWrap: true,
                                                                                      children: [
                                                                                        RadioListTile<String>(
                                                                                          activeColor: const Color(0xff3F710D),
                                                                                          title: Text('Diabetes', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                          value: 'Diabetes',
                                                                                          groupValue: tempSelectedGoal,
                                                                                          onChanged: (String? value) {
                                                                                            setState(() {
                                                                                              tempSelectedGoal = value!;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        RadioListTile<String>(
                                                                                          activeColor: const Color(0xff3F710D),
                                                                                          title: Text('Hypoglycemia', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                          value: 'Hypoglycemia',
                                                                                          groupValue: tempSelectedGoal,
                                                                                          onChanged: (String? value) {
                                                                                            setState(() {
                                                                                              tempSelectedGoal = value!;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        RadioListTile<String>(
                                                                                          activeColor: const Color(0xff3F710D),
                                                                                          title: Text('Hyperthyroidism', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                          value: 'Hyperthyroidism',
                                                                                          groupValue: tempSelectedGoal,
                                                                                          onChanged: (String? value) {
                                                                                            setState(() {
                                                                                              tempSelectedGoal = value!;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        RadioListTile<String>(
                                                                                          activeColor: const Color(0xff3F710D),
                                                                                          title: Text('Hypothyroidism', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                          value: 'Hypothyroidism',
                                                                                          groupValue: tempSelectedGoal,
                                                                                          onChanged: (String? value) {
                                                                                            setState(() {
                                                                                              tempSelectedGoal = value!;
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        RadioListTile<String>(
                                                                                          activeColor: const Color(0xff3F710D),
                                                                                          title: Text('Metabolic Syndrome', style: GoogleFonts.vazirmatn(fontSize: 14.sp)),
                                                                                          value: 'Metabolic Syndrome',
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
                                                                                  contentTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                                                                                  actions: [
                                                                                    TextButton(
                                                                                      child: Text(
                                                                                        'Cancel',
                                                                                        style: GoogleFonts.vazirmatn(color: Colors.red, fontSize: 14.sp),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                    TextButton(
                                                                                      child: Text(
                                                                                        'Ok',
                                                                                        style: GoogleFonts.vazirmatn(color: Colors.black, fontSize: 14.sp),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          medicalCondition = tempSelectedGoal;
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
                                                                              medicalCondition;
                                                                            });
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.07,
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                4,
                                                                            horizontal:
                                                                                16),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey),
                                                                          borderRadius:
                                                                              BorderRadius.circular(30),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            medicalCondition == null
                                                                                ? Text(
                                                                                    "Please select condition",
                                                                                    style: GoogleFonts.vazirmatn(color: Colors.grey),
                                                                                  )
                                                                                : Text(
                                                                                    "$medicalCondition",
                                                                                    style: GoogleFonts.vazirmatn(color: Colors.white),
                                                                                  ),
                                                                            const Icon(
                                                                              Icons.keyboard_arrow_down_sharp,
                                                                              color: Colors.grey,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
              const Spacer(),
              AppButton(
                text: "Next",
                onPressed: () async {
                  if (selectMedicalName == null) {
                    showSnackBar(context, "Please select medical");
                  } else if (selectMedicalName == "No,I’m fine" &&
                      medicalCondition == null) {
                    print(widget.weightUnit);
                    print("medicalCondition");

                    Nav.push(
                        context,
                        ChoosePlanScreen(
                            gender: widget.gender,
                            heightUnit: widget.heightUnit,
                            heightValue: widget.heightValue,
                            weightUnit: widget.weightUnit,
                            weightValue: widget.weightValue,
                            age: widget.age,
                            goal: widget.goal,
                            sleepHours: widget.sleepHours,
                            mealFrequency: widget.mealFrequency,
                            hydrationDaily: widget.hydrationDaily,
                            targetWeight: widget.targetWeight,
                            dietPlan: widget.dietPlan,
                            selectMedicalName: selectMedicalName!,
                            medicalCondition: ""));
                  } else if (selectMedicalName != null &&
                      medicalCondition == null) {
                    showSnackBar(context, "Please select condition");
                  } else {
                    Nav.push(
                        context,
                        ChoosePlanScreen(
                            gender: widget.gender,
                            heightUnit: widget.heightUnit,
                            heightValue: widget.heightValue,
                            weightUnit: widget.weightUnit,
                            weightValue: widget.weightValue,
                            age: widget.age,
                            goal: widget.goal,
                            sleepHours: widget.sleepHours,
                            mealFrequency: widget.mealFrequency,
                            hydrationDaily: widget.hydrationDaily,
                            targetWeight: widget.targetWeight,
                            dietPlan: widget.dietPlan,
                            selectMedicalName: selectMedicalName!,
                            medicalCondition: medicalCondition!));
                  }

                  // print(selectMedicalName);
                  // print(medicalCondition);
                  // Nav.push(context, const ChoosePlanScreen());
                },
              ),
               SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
