import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymmerator/bloC/auth_cubit/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:gymmerator/ui_component/app_button.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart'
    hide LoadingState;
import '../../../../../ui_component/show_snackbar.dart';
import '../../../../../utils/nav/nav.dart';

class AccountEditScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  // final String email;
  // final String phoneNumber;
  final String address1;
  final String address2;
  final String city;
  final String state;
  final String country;

  const AccountEditScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      // required this.email,
      // required this.phoneNumber,
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
    // phoneNumberController = TextEditingController(text: widget.phoneNumber);
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
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: const Text('Account Edit'),
                centerTitle: true,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            const AssetImage('assets/images/profile.png'),
                        // Replace with your image asset
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt, size: 15),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Enter your first name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline),
                          hintText: 'Enter your last name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
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
                      // const SizedBox(height: 20),
                      // TextFormField(
                      //   controller: phoneNumberController,
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Icons.phone_outlined),
                      //     hintText: 'Mobile Number',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: address1Controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'Address 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: address2Controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'Address 2',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'city',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: stateController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'state',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          hintText: 'country',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                      AppButton(
                        text: "Save",
                        onPressed: () async {
                          await _onSaveButtonPressed(context);
                        },
                      ),
                      const SizedBox(height: 10),
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
      context.read<UpdateUserInfoCubit>().editAccountRequest(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address1: address1Controller.text,
          address2: address2Controller.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text);
    }
  }
}
