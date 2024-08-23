import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/select_payment_method_screen.dart';
import 'package:gymmerator/ui_component/show_snackbar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../ui_component/app_button.dart';
import '../../../../../ui_component/app_textfield.dart';
import '../../../../../utils/nav/nav.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  const CheckoutScreen({super.key, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  TextEditingController deliveryAddressController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  @override
  void initState() {
    amountController =
        TextEditingController(text: widget.totalAmount.toStringAsFixed(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Nav.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(width: screenWidth * 0.2),
                  Text("Check out",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AppTextField(
                controller: nameController,
                hintText: "Name",
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AppTextField(
                controller: deliveryAddressController,
                hintText: "Delivery Address",
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              AppTextField(
                controller: billingAddressController,
                hintText: "Billing Address",
                color: Colors.grey,
                fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth / 2.4,
                    child: AppTextField(
                      controller: amountController,
                      hintText: "Amount",
                      color: Colors.grey,
                      fieldTextStyle:
                          GoogleFonts.vazirmatn(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: screenWidth / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCurrency,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: const SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCurrency = newValue!;
                            });
                          },
                          items: currencyList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth / 2.4,
                    child: AppTextField(
                      controller: cityController,
                      hintText: "City",
                      color: Colors.grey,
                      fieldTextStyle:
                          GoogleFonts.vazirmatn(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: screenWidth / 2.4,
                    child: AppTextField(
                      controller: stateController,
                      hintText: "State",
                      color: Colors.grey,
                      fieldTextStyle:
                          GoogleFonts.vazirmatn(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth / 2.4,
                    child: AppTextField(
                      controller: countryController,
                      hintText: "Country",
                      color: Colors.grey,
                      fieldTextStyle:
                          GoogleFonts.vazirmatn(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: screenWidth / 2.4,
                    child: AppTextField(
                      controller: postalCodeController,
                      hintText: "Postal code",
                      color: Colors.grey,
                      fieldTextStyle:
                          GoogleFonts.vazirmatn(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                text: "Continue",
                onPressed: () async {
                  if (nameController.text.isEmpty) {
                    showSnackBar(context, "Please enter Name");
                  } else if (deliveryAddressController.text.isEmpty) {
                    showSnackBar(context, "Please enter Delivery Address");
                  } else if (billingAddressController.text.isEmpty) {
                    showSnackBar(context, "Please enter Billing Address");
                  } else if (cityController.text.isEmpty) {
                    showSnackBar(context, "Please enter City");
                  } else if (stateController.text.isEmpty) {
                    showSnackBar(context, "Please enter State");
                  } else if (countryController.text.isEmpty) {
                    showSnackBar(context, "Please enter Country");
                  } else if (postalCodeController.text.isEmpty) {
                    showSnackBar(context, "Please enter Postal Code");
                  } else {
                    Nav.push(
                        context,
                        SelectPaymentMethodScreen(
                          totalAmount: widget.totalAmount,
                          deliveryAddress: deliveryAddressController.text,
                          billingAddress: billingAddressController.text,
                          name: nameController.text,
                          currency: selectedCurrency,
                          city: cityController.text,
                          state: stateController.text,
                          country: countryController.text,
                          postalCode: postalCodeController.text,
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
