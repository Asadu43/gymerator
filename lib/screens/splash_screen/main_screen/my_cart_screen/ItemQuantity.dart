import 'package:flutter/material.dart';

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
    // final GetCartItemsApiResponse checkOutModel = await context.read<CartItemsCubit>().changeQuantity(id: widget.id, quantity: count);
    // print('${checkOutModel}');
    //   if(checkOutModel.result == true){
    //     print('${checkOutModel}');
    //
    //     context.read<CartItemsCubit>().getCartItems(context);
    //   }else{
    //     showSnackBar(context,"Failed to Change Quantity");
    //   }
    // }else{
    //   showSnackBar(context,"Product Out Of Stock");
    // }
  }

  void decrement() async {
    // if (count > widget.qLimit) {
    setState(() {
      count--;
    });
    // final GetCartItemsApiResponse checkOutModel = await context.read<CartItemsCubit>().changeQuantity(id: widget.id, quantity: count);
    // if(checkOutModel.result == true){
    //   context.read<CartItemsCubit>().getCartItems(context);
    // }else{
    //   showSnackBar(context,"Failed to Change Quantity");
    // }
    // }
  }

  @override
  void initState() {
    super.initState();
    count = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: screenHeight * 0.035,
            width: screenWidth * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: IconButton(
                onPressed: decrement,
                icon: const Icon(
                  Icons.remove,
                  size: 15,
                ))),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        Text('$count'),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        Container(
            height: screenHeight * 0.035,
            width: screenWidth * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: IconButton(
                onPressed: increment,
                icon: const Icon(
                  Icons.add,
                  size: 15,
                ))),
      ],
    );
  }
}
