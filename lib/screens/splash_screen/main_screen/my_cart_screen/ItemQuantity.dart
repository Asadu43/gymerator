import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloC/auth_cubit/user_cart_product_cubit/user_cart_products_cubit.dart';
import '../../../../ui_component/show_snackbar.dart';

class ItemQuantity extends StatefulWidget {
  const ItemQuantity({
    super.key,
    required this.quantity,
    required this.id,
  });

  final int quantity;
  final String id;

  // final int qLimit;
  // final int uLimit;

  @override
  State<ItemQuantity> createState() => _ItemQuantityState();
}

class _ItemQuantityState extends State<ItemQuantity> {
  int count = 0;

  void increment() async {
    // if(count < widget.uLimit){

    setState(() {
      count++;
    });
    await context
        .read<UserCartProductsCubit>()
        .updateRequest(id: widget.id, quantity: 1);
  }

  void decrement() async {
    if (widget.quantity > 1) {
    setState(() {
      count--;
    });

    await context
        .read<UserCartProductsCubit>()
        .updateRequest(id: widget.id, quantity: -1);
    }else {
      showSnackBar(context, "Minimum one item required");
    }
  }

  @override
  void initState() {
    super.initState();
    count = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        InkWell(
          onTap: decrement,
          child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey)),
              child: const Icon(
                Icons.remove,
                size: 15,
              )),
        ),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        Text(
          '$count',
          style: GoogleFonts.vazirmatn(),
        ),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        InkWell(
          onTap: increment,
          child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey)),
              child: const Icon(
                Icons.add,
                size: 15,
              )),
        ),
      ],
    );
  }
}
