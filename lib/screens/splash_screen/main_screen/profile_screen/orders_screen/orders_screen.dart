import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/user_orders_cubit/user_orders_cubit.dart';
import 'package:gymmerator/models/api_response/GetAllUserOrdersApiResponse.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/profile_screen/orders_screen/orders_details_screen/order_details_screen.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../../ui_component/show_snackbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/nav/nav.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  GetAllUserOrdersApiResponse? response;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserOrdersCubit()..getAllOrdersRequest(),
      child: BlocConsumer<UserOrdersCubit, UserOrdersState>(
        listener: (context, state) {
          if (state is FailedToGetAllOrders) {
            showSnackBar(context, "No Order Found");
          }
          if (state is AllOrdersGetSuccessfully) {
            response = state.response;
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
                centerTitle: true,
                title: Text(
                  'Orders',
                  style: GoogleFonts.vazirmatn(),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body:
              // (response?.data == null)  ? const Center(child: Text("No Order found"),) :
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: response?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Nav.push(context, OrderDetailsScreen(id: response!.data![index].id!));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          // color: AppColors.whiteGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Order ID",style: GoogleFonts.vazirmatn(),),
                                Text(response?.data![index].id ?? "",style: GoogleFonts.vazirmatn(),),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text("Payment Method",style: GoogleFonts.vazirmatn(),),
                                Text(response?.data![index].paymentMethod ?? "",style: GoogleFonts.vazirmatn(),),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Status",style: GoogleFonts.vazirmatn()),
                                Text(
                                  response?.data![index].status ?? "",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order Price",style: GoogleFonts.vazirmatn()),
                                Text(
                                  "\$ ${response?.data![index].totalAmount ?? ""}",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 16,
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
