import 'package:country_state_city/models/city.dart';
import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/models/state.dart' as cs;
import 'package:country_state_city/utils/city_utils.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:country_state_city/utils/state_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/signup_cubit/signup_cubit.dart';
import 'package:gymmerator/screens/splash_screen/registration_screens/login_screen/login_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../../ui_component/app_button.dart';
import '../../../../ui_component/app_textfield.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/common/common.dart';
import '../../../../utils/nav/nav.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int isCurrentAddress = 0;
  bool isPasswordValid = false;

  getCurrentLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      currentCity = placeMarks[0].locality!;
      currentLat = position.latitude;
      currentLong = position.longitude;
      currentRegistrationAddress =
          '${placeMarks[0].street} ${placeMarks[0].subLocality} ${placeMarks[0].locality} ${placeMarks[0].country}';
      print(currentRegistrationAddress);
      print(currentCity);
      print(currentLat);
      print(currentLong);
    });
  }

  Country? selectedCountry;
  cs.State? selectedState;
  City? selectedCity;

  List<Country>? countryList;
  List<cs.State>? stateList;
  List<City> cityList = [];

  void loadCountries() async {
    countryList = await getAllCountries();
    setState(() {});
  }

  void loadStates(Country country) async {
    stateList = await getStatesOfCountry(country.isoCode);
    selectedState = null;
    selectedCity = null;
    cityList.clear();
    setState(() {});
  }

  void loadCities(cs.State state) async {
    cityList = await getStateCities(selectedCountry!.isoCode, state.isoCode);
    selectedCity = null;
    setState(() {});
  }

  @override
  void initState() {
    lat = 0;
    long = 0;
    city = '';
    registrationAddress = '';
    currentLat = 0;
    currentLong = 0;
    currentRegistrationAddress = '';
    currentCity = '';
    getCurrentLocation();
    loadCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignUpFailed) {
            showSnackBar(context, state.message);
          }
          if (state is SignUpSuccessful) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  // Replace with your image asset path
                  fit:
                      BoxFit.cover, // You can adjust the fit property as needed
                )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight / 14,
                        ),
                        Image.asset('assets/images/logo_g.png'),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Create Account",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white)),
                        Text("Please Sign up to get all the features",
                            style: GoogleFonts.vazirmatn(
                                fontSize: 11.sp, color: Colors.grey)),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: firstNameController,
                          hintText: "Enter your first name",
                          icon: const Icon(Icons.person_outline_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: lastNameController,
                          hintText: "Enter your last name",
                          icon: const Icon(Icons.person_outline_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: phoneNumberController,
                          textInputType: TextInputType.number,
                          hintText: "Mobile Number",
                          icon: const Icon(Icons.phone),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: addressController,
                          hintText: "Address 1",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: address2Controller,
                          hintText: "Address 2",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.07,
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: DropdownButton<Country>(
                              underline: const SizedBox(),
                              hint: Text(
                                'Select Country',
                                style: GoogleFonts.vazirmatn(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                              value: selectedCountry,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.white,
                              ),
                              dropdownColor: const Color(0xFF74994F),
                              items: countryList?.map((Country country) {
                                return DropdownMenuItem<Country>(
                                  value: country,
                                  child: Text(
                                    country.name,
                                    maxLines: 1,
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 12.sp, color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (Country? newCountry) {
                                setState(() {
                                  selectedCountry = newCountry;
                                  if (newCountry != null) {
                                    loadStates(newCountry);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (stateList != null && stateList!.isNotEmpty)
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.07,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: DropdownButton<cs.State>(
                                underline: const SizedBox(),
                                hint: Text(
                                  'Select State',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 12.sp, color: Colors.white),
                                ),
                                value: selectedState,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.white,
                                ),
                                dropdownColor: const Color(0xFF74994F),
                                items: stateList?.map((cs.State state) {
                                  return DropdownMenuItem<cs.State>(
                                    value: state,
                                    child: Text(state.name,
                                        maxLines: 1,
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 12.sp,
                                            color: Colors.white)),
                                  );
                                }).toList(),
                                onChanged: (cs.State? newState) {
                                  setState(() {
                                    selectedState = newState;
                                    if (newState != null) loadCities(newState);
                                  });
                                },
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (cityList.isNotEmpty)
                          Container(
                            width: double.infinity,
                            height: screenHeight * 0.07,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: DropdownButton<City>(
                                underline: const SizedBox(),
                                hint: Text(
                                  'Select City',
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 12.sp, color: Colors.white),
                                ),
                                value: selectedCity,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.white,
                                ),
                                dropdownColor: const Color(0xFF74994F),
                                items: cityList.map((City city) {
                                  return DropdownMenuItem<City>(
                                    value: city,
                                    child: Text(city.name,
                                        maxLines: 1,
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 12.sp,
                                            color: Colors.white)),
                                  );
                                }).toList(),
                                onChanged: (City? newCity) {
                                  setState(() {
                                    selectedCity = newCity;
                                  });
                                },
                              ),
                            ),
                          ),
                        (cityList.isNotEmpty)
                            ? const SizedBox(
                                height: 20,
                              )
                            : const SizedBox(),
                        AppTextField(
                          textInputType: TextInputType.number,
                          controller: postalCodeController,
                          hintText: "Enter your postal code",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          controller: passwordController,
                          hintText: "password",
                          obscureText: true,
                          icon: const Icon(Icons.lock_open_outlined),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                          text: "Sign up",
                          onPressed: () async {
                            await _onSignUpButtonPressed(context);
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 14, color: Colors.grey)),
                            InkWell(
                              onTap: () {
                                Nav.push(context, const LoginScreen());
                              },
                              child: Text("Sign In",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 14, color: Colors.white)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
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

  Future<void> _onSignUpButtonPressed(BuildContext context) async {
    if (firstNameController.text.isEmpty) {
      showSnackBar(context, "Please enter first name");
    } else if (lastNameController.text.isEmpty) {
      showSnackBar(context, "Please enter last name");
    } else if (emailController.text.isEmpty) {
      showSnackBar(context, "Please enter email");
    } else if (phoneNumberController.text.isEmpty) {
      showSnackBar(context, "Please enter mobile number");
    } else if (addressController.text.isEmpty &&
        address2Controller.text.isEmpty) {
      showSnackBar(context, "Please enter address");
    } else if (selectedCountry == null) {
      showSnackBar(context, "Please select country");
    } else if (selectedState == null) {
      showSnackBar(context, "Please select state");
    } else if (cityList.isNotEmpty && selectedCity == null) {
      showSnackBar(context, "Please select city");
    } else if (postalCodeController.text.isEmpty) {
      showSnackBar(context, "Please enter postal code");
    } else if (passwordController.text.isEmpty) {
      showSnackBar(context, "Please enter password");
    } else {
      validatePassword(passwordController.text);
      if (isPasswordValid == false) {
        showSnackBar(context,
            "Password must be at least 9 characters and include uppercase, lowercase, number, and special character.");
      } else {
        context.read<SignupCubit>().signUp(
              firstname: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              phoneNumber: phoneNumberController.text,
              address1: addressController.text,
              address2: address2Controller.text,
              city: cityList.isNotEmpty ? selectedCity!.name : "",
              state: selectedState!.name,
              country: selectedCountry!.name,
              postalCode: postalCodeController.text,
              password: passwordController.text,
              lat: currentLat.toString(),
              long: currentLong.toString(),
            );
      }
    }
  }

  final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{9,}$');

  void validatePassword(String password) {
    setState(() {
      isPasswordValid = passwordRegExp.hasMatch(password);
    });
  }
}
