import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  String _selectedCountryCode = "+1";

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
                height: 1.sh, // Full screen height
                width: 1.sw,  // Full screen width
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        Image.asset('assets/images/logo_g.png'),
                        SizedBox(height: 20.h),
                        Text(
                          "Create Account",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          "Please Sign up to get all the features",
                          style: GoogleFonts.vazirmatn(
                            fontSize: 11.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: firstNameController,
                          hintText: "Enter your first name",
                          icon: const Icon(Icons.person_outline_outlined),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: lastNameController,
                          hintText: "Enter your last name",
                          icon: const Icon(Icons.person_outline_outlined),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: emailController,
                          hintText: "Enter your email",
                          icon: const Icon(Icons.email_outlined),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          height: 53.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 0.3.sw,
                                child: CountryCodePicker(
                                  onChanged: (countryCode) {
                                    setState(() {
                                      _selectedCountryCode = countryCode.dialCode!;
                                    });
                                  },
                                  showFlag: false,
                                  textStyle: GoogleFonts.vazirmatn(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  showDropDownButton: true,
                                  showFlagDialog: true,
                                  enabled: true,
                                  hideSearch: true,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Colors.white,
                                  style: GoogleFonts.vazirmatn(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter your phone number',
                                    hintStyle: GoogleFonts.vazirmatn(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                    prefixStyle: GoogleFonts.vazirmatn(color: Colors.white),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: addressController,
                          hintText: "Address 1",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: address2Controller,
                          hintText: "Address 2",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          height: 53.h,
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Center(
                            child: DropdownButton<Country>(
                              underline: const SizedBox(),
                              hint: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Select Country',
                                  style: GoogleFonts.vazirmatn(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                              value: selectedCountry,
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.grey,
                              ),
                              dropdownColor: Colors.white,
                              items: countryList?.map((Country country) {
                                return DropdownMenuItem<Country>(
                                  value: country,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      country.name,
                                      maxLines: 1,
                                      style: GoogleFonts.vazirmatn(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                    ),
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
                              selectedItemBuilder: (BuildContext context) {
                                return countryList
                                        ?.map<Widget>((Country country) {
                                      return Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          country.name,
                                          style: GoogleFonts.vazirmatn(
                                            fontSize: 12.sp,
                                            color: Colors
                                                .white, // Selected item text color in the button
                                          ),
                                        ),
                                      );
                                    }).toList() ??
                                    [];
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
                            height:53.h,
                            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Center(
                              child: DropdownButton<cs.State>(
                                underline: const SizedBox(),
                                hint: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select State',
                                    style: GoogleFonts.vazirmatn(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                value: selectedState,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.grey,
                                ),
                                dropdownColor:
                                    Colors.white, // Dropdown background color
                                items: stateList?.map((cs.State state) {
                                  return DropdownMenuItem<cs.State>(
                                    value: state,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        state.name,
                                        maxLines: 1,
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp,
                                          color: Colors
                                              .black, // Text color in dropdown
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (cs.State? newState) {
                                  setState(() {
                                    selectedState = newState;
                                    if (newState != null) loadCities(newState);
                                  });
                                },
                                selectedItemBuilder: (BuildContext context) {
                                  return stateList
                                          ?.map<Widget>((cs.State state) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.name,
                                            style: GoogleFonts.vazirmatn(
                                              fontSize: 14.sp,
                                              color: Colors
                                                  .white, // Selected item text color in the button
                                            ),
                                          ),
                                        );
                                      }).toList() ??
                                      [];
                                },
                              ),
                            ),
                          ),

                         SizedBox(
                          height: 20.h,
                        ),
                        if (cityList.isNotEmpty)
                          Container(
                            height: 53.h,
                            padding:  EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Center(
                              child: DropdownButton<City>(
                                underline: const SizedBox(),
                                hint: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select City',
                                    style: GoogleFonts.vazirmatn(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                value: selectedCity,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.grey,
                                ),
                                dropdownColor:
                                    Colors.white, // Dropdown background color
                                items: cityList.map((City city) {
                                  return DropdownMenuItem<City>(
                                    value: city,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        city.name,
                                        maxLines: 1,
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp,
                                          color: Colors
                                              .black, // Text color in dropdown
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (City? newCity) {
                                  setState(() {
                                    selectedCity = newCity;
                                  });
                                },
                                selectedItemBuilder: (BuildContext context) {
                                  return cityList.map<Widget>((City city) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        city.name,
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 14.sp,
                                          color: Colors
                                              .white, // Selected item text color in the button
                                        ),
                                      ),
                                    );
                                  }).toList();
                                },
                              ),
                            ),
                          ),
                        (cityList.isNotEmpty)
                            ?  SizedBox(
                                height: 20.h,
                              )
                            : const SizedBox(),
                        AppTextField(
                          textInputType: TextInputType.number,
                          controller: postalCodeController,
                          hintText: "Postal code",
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          controller: passwordController,
                          hintText: "Password",
                          obscureText: true,
                          icon: const Icon(Icons.lock_open_outlined),
                        ),
                        SizedBox(height: 20.h),
                        AppButton(
                          text: "Sign up",
                          onPressed: () async {
                            await _onSignUpButtonPressed(context);
                          },
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: GoogleFonts.vazirmatn(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Nav.push(context, const LoginScreen());
                              },
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.vazirmatn(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
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
        String fullNumber = getFullPhoneNumber();
        context.read<SignupCubit>().signUp(
              firstname: firstNameController.text,
              lastName: lastNameController.text,
              email: emailController.text,
              phoneNumber: fullNumber,
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

  // Method to get the concatenated phone number
  String getFullPhoneNumber() {
    String phoneNumber = phoneNumberController.text;

    // Remove any non-digit characters and leading '0' if it exists
    phoneNumber = phoneNumber.replaceAll(
        RegExp(r'[^0-9]'), ''); // Remove non-digit characters
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1); // Remove the leading '0'
    }

    // Concatenate the country code and the phone number
    String fullPhoneNumber = '$_selectedCountryCode$phoneNumber';

    return fullPhoneNumber;
  }
}
