import 'package:flutter/material.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum WeightUnits { kg, lb }

enum HeightUnits { cm, ftIn }

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController weightLbController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();
  WeightUnits weightUnit = WeightUnits.kg;
  HeightUnits heightUnit = HeightUnits.cm;
  double weightLb = 0;
  double weightKg = 0;
  double heightFeet = 0;
  double heightInches = 0;
  double heightCm = 0;
  int age = 20;
  String? goal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleSwitch(
                          initialLabelIndex:
                              weightUnit == WeightUnits.kg ? 0 : 1,
                          totalSwitches: 2,
                          activeBgColor: const [
                            Color(0xffB14501),
                            Color(0xff3F710D)
                          ],
                          labels: const ['Kg', 'Lb'],
                          onToggle: (index) {
                            setState(() {
                              weightUnit =
                                  index == 0 ? WeightUnits.kg : WeightUnits.lb;
                            });
                          },
                        ),
                        SizedBox(
                          width: 50,
                          child: TextField(
                            cursorColor: Colors.black,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              suffixText:
                                  weightUnit == WeightUnits.kg ? 'Kg' : 'Lb',
                              suffixStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isEmpty) {
                                return;
                              }
                              setState(() {
                                if (weightUnit == WeightUnits.kg) {
                                  weightKg = double.parse(value);
                                } else {
                                  weightLb = double.parse(value);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleSwitch(
                          initialLabelIndex:
                              heightUnit == HeightUnits.cm ? 0 : 1,
                          totalSwitches: 2,
                          activeBgColor: const [
                            Color(0xffB14501),
                            Color(0xff3F710D)
                          ],
                          labels: const ['Cm', 'Ft-In'],
                          onToggle: (index) {
                            setState(() {
                              heightUnit = index == 0
                                  ? HeightUnits.cm
                                  : HeightUnits.ftIn;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: heightUnit == HeightUnits.cm
                              ? [
                                  buildTextField(heightCmController, (value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    setState(() {
                                      heightCm = double.parse(value);
                                    });
                                  }, 'Cm')
                                ]
                              : [
                                  buildTextField(heightFeetController, (value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    setState(() {
                                      heightFeet = double.parse(value);
                                    });
                                  }, 'Ft'),
                                  buildTextField(heightInchesController,
                                      (value) {
                                    if (value.isEmpty) {
                                      return;
                                    }
                                    setState(() {
                                      heightInches = double.parse(value);
                                    });
                                  }, 'In'),
                                ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter your age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButton<String>(
                underline: Container(),
                isExpanded: true,
                hint: const Text('Select your goal'),
                value: goal,
                items: <String>['Lose Weight', 'Gain Weight', 'Maintain Weight']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newGoal) {
                  setState(() {
                    goal = newGoal!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            AppButton(
              text: "Save",
              onPressed: () {
                // Handle save button action
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildTextField(TextEditingController controller,
      Function(String)? onChanged, String suffixText) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.all(0),
          suffixText: suffixText,
          suffixStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
