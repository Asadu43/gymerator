import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/models/product_model.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/product_item_card.dart';

class FeaturedProductsScreen extends StatefulWidget {
  const FeaturedProductsScreen({super.key});

  @override
  State<FeaturedProductsScreen> createState() => _FeaturedProductsScreenState();
}

class _FeaturedProductsScreenState extends State<FeaturedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Featured Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextField(
                  hintText: 'Search products',
                  icon: const Icon(Icons.search),
                  color: Colors.grey,
                  prefixIconColor: Colors.grey,
                  fieldTextStyle: GoogleFonts.vazirmatn(color: Colors.black),
                )),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                itemCount: featuredProducts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    product: featuredProducts[index],
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Product> featuredProducts = [
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product3.png',
    name: 'Product 3',
    description: 'This is the description of Product 3',
    price: 290.9,
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product4.png',
    name: 'Product 4',
    description: 'This is the description of Product 4',
    price: 190.9,
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product5.png',
    name: 'Product 5',
    description: 'This is the description of Product 5',
    price: 290.9,
    like: true,
  ),
];
