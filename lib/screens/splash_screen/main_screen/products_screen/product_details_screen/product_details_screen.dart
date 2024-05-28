import 'package:flutter/material.dart';
import 'package:gymmerator/models/product_model.dart';
import 'package:gymmerator/utils/app_colors/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.product.imageUrl,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.product.like = !widget.product.like;
                    });
                  },
                  child: widget.product.like
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border, color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$15.56',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: _decrementQuantity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: _incrementQuantity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
            ),
            const SizedBox(height: 16),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.prductBuyNowButtonColor, width: 2),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.prductBuyNowButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 5),
                            blurRadius: 5.0)
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        // stops: const [0.0, 1.0],
                        colors: [
                          Color(0xffB14501),
                          Color(0xff3F710D),
                        ],
                      ),
                      // color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text("Add to Cart",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
