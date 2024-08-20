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
  final double totalAmount;
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
  TextEditingController pinCodeController = TextEditingController();

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
          amount: (int.parse(widget.totalAmount.round().toString()) * 100).toString(),
          currency: selectedCurrency,
          name: nameController.text,
          address: addressController.text,
          pin: pinCodeController.text,
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
                                  controller: pinCodeController,
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
                                pinCodeController.clear();
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
}
