// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gymmerator/bloC/auth_cubit/create_order_cubit/create_order_cubit.dart';
// import 'package:gymmerator/ui_component/loading_screen_animation.dart';
// import 'package:gymmerator/ui_component/show_snackbar.dart';
//
// import '../../../../../../ui_component/payment.dart';
// import '../../../../../../ui_component/reusable_text_field.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// import '../../../../../../utils/nav/nav.dart';
// import '../../../main_screen.dart';
//
// class PaymentScreen extends StatefulWidget {
//   final double totalAmount;
//   final String deliveryAddress;
//   final String billingAddress;
//   final String paymentMethod;
//   const PaymentScreen(
//       {super.key,
//       required this.totalAmount,
//       required this.deliveryAddress,
//       required this.billingAddress,
//       required this.paymentMethod});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   TextEditingController amountController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController countryController = TextEditingController();
//   TextEditingController pinCodeController = TextEditingController();
//
//   final formkey = GlobalKey<FormState>();
//   final formkey1 = GlobalKey<FormState>();
//   final formkey2 = GlobalKey<FormState>();
//   final formkey3 = GlobalKey<FormState>();
//   final formkey4 = GlobalKey<FormState>();
//   final formkey5 = GlobalKey<FormState>();
//   final formkey6 = GlobalKey<FormState>();
//
//   List<String> currencyList = <String>[
//     'USD',
//     'INR',
//     'EUR',
//     'JPY',
//     'GBP',
//     'AED'
//   ];
//   String selectedCurrency = 'USD';
//
//   bool hasDonated = false;
//
//   var data;
//
//   Future<void> initPaymentSheet() async {
//     try {
//       // 1. create payment intent on the client side by calling stripe api
//        data = await createPaymentIntent(
//           // convert string to double
//           amount: (int.parse(widget.totalAmount.round().toString()) * 100)
//               .toString(),
//           currency: selectedCurrency,
//           name: nameController.text,
//           address: addressController.text,
//           postalCode: pinCodeController.text,
//           city: cityController.text,
//           state: stateController.text,
//           country: countryController.text);
//
//       // 2. initialize the payment sheet
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         // Set to true for custom flow
//         customFlow: false,
//         // Main params
//         merchantDisplayName: 'Test Merchant',
//         paymentIntentClientSecret: data['client_secret'],
//         // Customer keys
//         customerEphemeralKeySecret: data['ephemeralKey'],
//         customerId: data['id'],
//         style: ThemeMode.dark,
//         appearance: const PaymentSheetAppearance(
//             colors:
//                 PaymentSheetAppearanceColors(background: Color(0xff3F710D))),
//       ));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       rethrow;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return BlocProvider(
//       create: (context) => CreateOrderCubit(),
//       child: BlocConsumer<CreateOrderCubit, CreateOrderState>(
//         listener: (context, state) {
//           if (state is FailedToOrderCreate) {
//             showSnackBar(
//                 context, state.response.message ?? "Create Order Failed");
//           }
//           if (state is CreateOrderSuccessfully) {
//             showSnackBar(
//                 context, state.response.message ?? "Order Create Successfully",
//                 type: SnackBarType.success);
//
//             Nav.pushAndRemoveAllRoute(context, const MainScreen());
//           }
//         },
//         builder: (context, state) {
//           return LoadingScreenAnimation(
//             isLoading: state is LoadingState,
//             child: SafeArea(
//               child: Scaffold(
//                 body: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Column(
//                       children: [
//                         const Image(
//                             image: AssetImage("assets/images/logo_g.png"),
//                             height: 200,
//                             // width: double.infinity,
//                             fit: BoxFit.cover),
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     "Payment Details",
//                                     style: TextStyle(
//                                         fontSize: 28,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         flex: 5,
//                                         child: ReusableTextField(
//                                             formkey: formkey,
//                                             controller: amountController
//                                               ..text =
//                                                   widget.totalAmount.toString(),
//                                             isNumber: true,
//                                             title: "Amount",
//                                             hint: "amount"),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       DropdownMenu<String>(
//                                         inputDecorationTheme:
//                                             InputDecorationTheme(
//                                           contentPadding:
//                                               const EdgeInsets.symmetric(
//                                                   horizontal: 0),
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Colors.grey.shade600,
//                                             ),
//                                           ),
//                                         ),
//                                         initialSelection: currencyList.first,
//                                         onSelected: (String? value) {
//                                           // This is called when the user selects an item.
//                                           setState(() {
//                                             selectedCurrency = value!;
//                                           });
//                                         },
//                                         dropdownMenuEntries: currencyList
//                                             .map<DropdownMenuEntry<String>>(
//                                                 (String value) {
//                                           return DropdownMenuEntry<String>(
//                                               value: value, label: value);
//                                         }).toList(),
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   ReusableTextField(
//                                       formkey: formkey1,
//                                       title: "Name",
//                                       hint: "Ex. John Doe",
//                                       controller: nameController),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   ReusableTextField(
//                                       formkey: formkey2,
//                                       title: "Address Line",
//                                       hint: "Ex. 123 Main St",
//                                       controller: addressController),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: screenWidth / 2.5,
//                                         child: ReusableTextField(
//                                             formkey: formkey3,
//                                             title: "City",
//                                             hint: "Ex. New Delhi",
//                                             controller: cityController),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       SizedBox(
//                                         width: screenWidth / 2.5,
//                                         child: ReusableTextField(
//                                             formkey: formkey4,
//                                             title: "State (Short code)",
//                                             hint: "Ex. DL for Delhi",
//                                             controller: stateController),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: screenWidth / 2.5,
//                                         child: ReusableTextField(
//                                             formkey: formkey5,
//                                             title: "Country (Short Code)",
//                                             hint: "Ex. PK for Pak",
//                                             controller: countryController),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       SizedBox(
//                                         width: screenWidth / 2.5,
//                                         child: ReusableTextField(
//                                             formkey: formkey6,
//                                             title: "Pincode",
//                                             hint: "Ex. 123456",
//                                             controller: pinCodeController,
//                                             isNumber: true),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 120),
//                                   SizedBox(
//                                     height: 50,
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               Colors.blueAccent.shade400),
//                                       child: const Text(
//                                         "Proceed to Pay",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 16),
//                                       ),
//                                       onPressed: () async {
//                                         if (formkey.currentState!.validate() &&
//                                             formkey1.currentState!.validate() &&
//                                             formkey2.currentState!.validate() &&
//                                             formkey3.currentState!.validate() &&
//                                             formkey4.currentState!.validate() &&
//                                             formkey5.currentState!.validate() &&
//                                             formkey6.currentState!.validate()) {
//                                           await initPaymentSheet();
//
//                                           try {
//                                             await Stripe.instance
//                                                 .presentPaymentSheet();
//                                             context.read<CreateOrderCubit>().createRequest(shippingAddress: widget.deliveryAddress, paymentAddress: widget.billingAddress, paymentMethod: widget.paymentMethod, paymentIntentId: data['id'], amount: int.parse(widget.totalAmount.round().toString()), currency: selectedCurrency);
//                                           } catch (e) {
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(const SnackBar(
//                                                     content: Text(
//                                                       "Payment Failed",
//                                                       style: TextStyle(
//                                                           color: Colors.white),
//                                                     ),
//                                                     backgroundColor:
//                                                         Colors.redAccent));
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   )
//                                 ])),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
