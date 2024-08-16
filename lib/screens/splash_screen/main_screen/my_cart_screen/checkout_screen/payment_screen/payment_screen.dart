import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/my_cart_screen/checkout_screen/payment_screen/order_summary_screen/order_summary_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../ui_component/app_button.dart';
import '../../../../../../ui_component/app_textfield.dart';
import '../../../../../../ui_component/payment.dart';
import '../../../../../../ui_component/reusable_text_field.dart';
import '../../../../../../utils/nav/nav.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  final int totalAmount;
  const PaymentScreen({super.key, required this.totalAmount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final formkey4 = GlobalKey<FormState>();
  final formkey5 = GlobalKey<FormState>();
  final formkey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  bool hasDonated = false;

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
          // convert string to double
          amount: (int.parse(amountController.text) * 100).toString(),
          currency: selectedCurrency,
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],

          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
                image: AssetImage("assets/images/logo_g.png"),
                height: 200,
                // width: double.infinity,
                fit: BoxFit.cover),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Details",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ReusableTextField(
                                formkey: formkey,
                                controller: amountController
                                  ..text = widget.totalAmount.toString(),
                                isNumber: true,
                                title: "Amount",
                                hint: "amount"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownMenu<String>(
                            inputDecorationTheme: InputDecorationTheme(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            initialSelection: currencyList.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                selectedCurrency = value!;
                              });
                            },
                            dropdownMenuEntries: currencyList
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      ReusableTextField(
                          formkey: formkey1,
                          title: "Name",
                          hint: "Ex. John Doe",
                          controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextField(
                          formkey: formkey2,
                          title: "Address Line",
                          hint: "Ex. 123 Main St",
                          controller: addressController),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                  formkey: formkey3,
                                  title: "City",
                                  hint: "Ex. New Delhi",
                                  controller: cityController)),
                          const SizedBox(width: 10),
                          Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                  formkey: formkey4,
                                  title: "State (Short code)",
                                  hint: "Ex. DL for Delhi",
                                  controller: stateController)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                  formkey: formkey5,
                                  title: "Country (Short Code)",
                                  hint: "Ex. IN for India",
                                  controller: countryController)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                  formkey: formkey6,
                                  title: "Pincode",
                                  hint: "Ex. 123456",
                                  controller: pincodeController,
                                  isNumber: true)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent.shade400),
                          child: const Text(
                            "Proceed to Pay",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () async {
                            if (formkey.currentState!.validate() &&
                                formkey1.currentState!.validate() &&
                                formkey2.currentState!.validate() &&
                                formkey3.currentState!.validate() &&
                                formkey4.currentState!.validate() &&
                                formkey5.currentState!.validate() &&
                                formkey6.currentState!.validate()) {
                              await initPaymentSheet();

                              try {
                                await Stripe.instance.presentPaymentSheet();

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Payment Done",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                ));

                                setState(() {
                                  hasDonated = true;
                                });
                                nameController.clear();
                                addressController.clear();
                                cityController.clear();
                                stateController.clear();
                                countryController.clear();
                                pincodeController.clear();
                              } catch (e) {
                                print("payment sheet failed");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                          "Payment Failed",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.redAccent));
                              }
                            }
                          },
                        ),
                      )
                    ])),
          ],
        ),
      ),
    );
  }
  // int saveCard = -1;
  // int payPalCard = -1;
  //
  // int _selectedValue = 1;
  //
  // @override
  // Widget build(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //   final screenHeight = MediaQuery.of(context).size.height;
  //   return Scaffold(
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   IconButton(
  //                       onPressed: () {
  //                         Nav.pop(context);
  //                       },
  //                       icon: const Icon(Icons.arrow_back_ios)),
  //                   SizedBox(width: screenWidth * 0.2),
  //                   Text("Payment Method",
  //                       style: GoogleFonts.vazirmatn(
  //                           fontSize: 14.sp,
  //                           fontWeight: FontWeight.bold,
  //                           color: Colors.black)),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.05,
  //               ),
  //               Text("\$ 32.00",
  //                   style: GoogleFonts.vazirmatn(
  //                       fontSize: 20.sp,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black)),
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.grey,
  //                     borderRadius: BorderRadius.circular(5)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Text("View detailed order",
  //                       style: GoogleFonts.vazirmatn(
  //                           fontSize: 11.sp, color: Colors.black)),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.04,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: RadioListTile(
  //                       value: 1,
  //                       activeColor: const Color(0xff3F710D),
  //                       fillColor: MaterialStateProperty.resolveWith(
  //                         (states) {
  //                           if (states.contains(MaterialState.selected)) {
  //                             return const Color(0xff3F710D);
  //                           }
  //                           return const Color(0xff3F710D);
  //                         },
  //                       ),
  //                       groupValue: _selectedValue,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           _selectedValue = value!;
  //                         });
  //                       },
  //                       title: Text(
  //                         "Credit/Debit Card",
  //                         style: GoogleFonts.vazirmatn(
  //                             color: Colors.black, fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       Image.asset(
  //                         "assets/images/visa.png",
  //                         width: 60,
  //                         height: 60,
  //                       ),
  //                       Image.asset(
  //                         "assets/images/master.png",
  //                         width: 60,
  //                         height: 60,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 16.0, right: 16.0),
  //                 child: Text(
  //                     "Pay securely with your Bank Account using Visa or Mastercard",
  //                     style: GoogleFonts.vazirmatn(
  //                         fontSize: 11.sp, color: Colors.grey)),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.02,
  //               ),
  //                AppTextField(
  //                 hintText: "Card Number",
  //                 color: Colors.grey,
  //                 fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.02,
  //               ),
  //                AppTextField(
  //                 hintText: "Card Name",
  //                 color: Colors.grey,
  //                 fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.02,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: MediaQuery.of(context).size.width * 0.4,
  //                     height: MediaQuery.of(context).size.height * 0.060,
  //                     padding: const EdgeInsets.only(left: 12),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(30),
  //                       border: Border.all(color: Colors.grey),
  //                     ),
  //                     child: TextField(
  //                       textAlign: TextAlign.start,
  //                       style: GoogleFonts.vazirmatn(color: Colors.black),
  //                       decoration: InputDecoration(
  //                           // icon: icon,
  //                           hintText: "MM/YY",
  //                           border: InputBorder.none,
  //                           hintStyle: GoogleFonts.barlow(
  //                               fontSize: 14, color: Colors.grey)),
  //                     ),
  //                   ),
  //                   Container(
  //                     width: MediaQuery.of(context).size.width * 0.4,
  //                     height: MediaQuery.of(context).size.height * 0.060,
  //                     padding: const EdgeInsets.only(left: 12),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(30),
  //                       border: Border.all(color: Colors.grey),
  //                     ),
  //                     child: TextField(
  //                       textAlign: TextAlign.start,
  //                       style: GoogleFonts.vazirmatn(color: Colors.black),
  //                       decoration: InputDecoration(
  //                           // icon: icon,
  //                           hintText: "CVC",
  //                           border: InputBorder.none,
  //                           hintStyle: GoogleFonts.barlow(
  //                               fontSize: 14, color: Colors.grey)),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.03,
  //               ),
  //               RadioListTile(
  //                 value: 1,
  //                 activeColor: const Color(0xff3F710D),
  //                 fillColor: MaterialStateProperty.resolveWith(
  //                   (states) {
  //                     if (states.contains(MaterialState.selected)) {
  //                       return const Color(0xff3F710D);
  //                     }
  //                     return const Color(0xff3F710D);
  //                   },
  //                 ),
  //                 groupValue: saveCard,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     saveCard = value!;
  //                   });
  //                 },
  //                 title: Text(
  //                   "Save card for future payments",
  //                   style: GoogleFonts.vazirmatn(
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: RadioListTile(
  //                       value: 1,
  //                       activeColor: const Color(0xff3F710D),
  //                       fillColor: MaterialStateProperty.resolveWith(
  //                         (states) {
  //                           if (states.contains(MaterialState.selected)) {
  //                             return const Color(0xff3F710D);
  //                           }
  //                           return const Color(0xff3F710D);
  //                         },
  //                       ),
  //                       groupValue: payPalCard,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           payPalCard = value!;
  //                         });
  //                       },
  //                       title: Text(
  //                         "PayPal",
  //                         style: GoogleFonts.vazirmatn(
  //                             color: Colors.black, fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                   ),
  //                   Row(
  //                     children: [
  //                       Image.asset(
  //                         "assets/images/paypal.png",
  //                         width: 60,
  //                         height: 60,
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 16.0, right: 16.0),
  //                 child: Text(
  //                     "Pay securely with your Bank Account using Visa or Mastercard",
  //                     style: GoogleFonts.vazirmatn(
  //                         fontSize: 11.sp, color: Colors.grey)),
  //               ),
  //               SizedBox(
  //                 height: screenHeight * 0.08,
  //               ),
  //               AppButton(
  //                 text: "Confirm and Continue",
  //                 onPressed: () async {
  //                   Nav.push(context, const OrderSummaryScreen());
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
