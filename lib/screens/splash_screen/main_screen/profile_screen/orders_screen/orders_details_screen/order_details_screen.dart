import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/bloC/auth_cubit/orders_details_cubit/orders_details_cubit.dart';
import 'package:gymmerator/models/api_response/UserOrderDetailsApiResponse.dart';
import 'package:gymmerator/ui_component/loading_screen_animation.dart';

import '../../../../../../ui_component/show_snackbar.dart';
import '../../../../../../utils/api_constants/api_constants.dart';
import '../../../../../../utils/app_colors/app_colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String id;
  const OrderDetailsScreen({super.key, required this.id});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  UserOrderDetailsApiResponse? response;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersDetailsCubit()..detailRequest(id: widget.id),
      child: BlocConsumer<OrdersDetailsCubit, OrdersDetailsState>(
        listener: (context, state) {
          if (state is FailedToGetOrdersDetail) {
            showSnackBar(context,
                state.response.message ?? "Failed To Get Order Detail");
          }
          if (state is OrdersDetailGetSuccessfully) {
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
                  'Order Detail',
                  style: GoogleFonts.vazirmatn(),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: response?.data?.products?.length ?? 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Nav.push(context, Order)
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        response?.data?.products![index].product
                                                ?.name ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.vazirmatn(
                                          fontSize: 20,
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        "Quantity  ${response?.data?.products![index].quantity ?? ""}",
                                        style: GoogleFonts.vazirmatn(
                                            fontSize: 14)),
                                  ],
                                ),
                                Container(
                                    height: 150,
                                    width: 150,
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${ApiConstants.baseUrl}/product/image/${response?.data?.products![index].product?.images?.first}"),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Payment Method"),
                                Text(response?.data?.paymentMethod ?? ""),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Status",
                                    style: GoogleFonts.vazirmatn()),
                                Text(
                                  response?.data?.status ?? "",
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
                                Text("Order Price",
                                    style: GoogleFonts.vazirmatn()),
                                Text(
                                  "\$ ${response?.data?.totalAmount ?? ""}",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 16,
                                      color: AppColors.background,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
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
