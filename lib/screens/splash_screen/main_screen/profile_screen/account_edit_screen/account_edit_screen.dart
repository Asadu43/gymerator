import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart'
    hide LoadingState;
import '../../../../../ui_component/show_snackbar.dart';
import '../../../../../utils/api_constants/api_constants.dart';
import '../../../../../utils/nav/nav.dart';

class AccountEditScreen extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String mobileNumber;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;
  final String? image;

  const AccountEditScreen(this.image,
      {super.key,
      required this.firstName,
      required this.lastName,
      // required this.email,
      required this.mobileNumber,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.country});

  @override
  State<AccountEditScreen> createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  XFile? _image;
  dynamic profileImage;

  Future _imgFromGallery() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    address1Controller = TextEditingController(text: widget.address1);
    address2Controller = TextEditingController(text: widget.address2);
    cityController = TextEditingController(text: widget.city);
    stateController = TextEditingController(text: widget.state);
    countryController = TextEditingController(text: widget.country);
    // emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.mobileNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateUserInfoCubit(),
      child: BlocConsumer<UpdateUserInfoCubit, UpdateUserInfoState>(
        listener: (context, state) {
          if (state is FailedToUpdateUserInfo) {
            showSnackBar(context, state.message);
          }
          if (state is UpdateUserSuccessfully) {
            showSnackBar(context, state.message, type: SnackBarType.success);
            context.read<AllFavoriteProductsCubit>().featuredRequest();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Nav.pop(context);
          }
        },
        builder: (context, state) {
          return LoadingScreenAnimation(
            isLoading: state is LoadingState,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 20.h),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  'Account Edit',
                  style: GoogleFonts.vazirmatn(
                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(children: [
                          Center(
                            child: Container(
                              height: 0.19.sh,
                              width: 0.4.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: widget.image == null
                                          ? Center(
                                              child: Text(
                                                widget.firstName[0]
                                                    .toUpperCase(),
                                                style: GoogleFonts.vazirmatn(
                                                    fontSize: 40.sp,
                                                    color: Colors.black),
                                              ),
                                            )
                                          : Image.network(
                                              "${ApiConstants.baseUrl}/profile/${widget.image}",
                                              fit: BoxFit.cover,
                                            )),
                            ),
                          ),
                          Positioned(
                              bottom: -20.h,
                              right: 0.3.sw,
                              child: GestureDetector(
                                onTap: () {
                                  _imgFromGallery();
                                },
                                child: Container(
                                  height: 0.1.sh,
                                  width: 0.1.sw,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade300,
                                  ),
                                  child: const Icon(Icons.camera_alt_outlined,
                                      color: Colors.grey),
                                ),
                              ))
                        ]),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Enter your last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      // SizedBox(height: 20.h),
                      // TextFormField(
                      //   controller: emailController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.email_outlined),
                      //     hintText: 'Enter your email',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_outlined),
                          hintText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: address1Controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'Address 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: address2Controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'Address 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'state',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'country',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),
                      AppButton(
                        text: "Save",
                        onPressed: () async {
                          await _onSaveButtonPressed(context);
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _onSaveButtonPressed(BuildContext context) async {
    if (firstNameController.text.isEmpty) {
      showSnackBar(context, "Please enter first name");
    } else if (lastNameController.text.isEmpty) {
      showSnackBar(context, "Please enter last name");
    } else if (address1Controller.text.isEmpty &&
        address2Controller.text.isEmpty) {
      showSnackBar(context, "Please enter address");
    } else if (cityController.text.isEmpty) {
      showSnackBar(context, "Please enter city");
    } else if (stateController.text.isEmpty) {
      showSnackBar(context, "Please enter state");
    } else if (countryController.text.isEmpty) {
      showSnackBar(context, "Please enter Country");
    } else {
      if (_image != null) {
        context.read<UpdateUserInfoCubit>().editAccountRequest(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            mobileNumber: phoneNumberController.text,
            address1: address1Controller.text,
            address2: address2Controller.text,
            city: cityController.text,
            state: stateController.text,
            country: countryController.text,
            profileImage: _image);
      } else {
        context.read<UpdateUserInfoCubit>().editAccountRequest(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            mobileNumber: phoneNumberController.text,
            address1: address1Controller.text,
            address2: address2Controller.text,
            city: cityController.text,
            state: stateController.text,
            country: countryController.text);
      }
    }
  }
}
