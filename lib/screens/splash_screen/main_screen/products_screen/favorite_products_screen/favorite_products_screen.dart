import 'package:flutter/material.dart';
import 'package:gymmerator/models/product_model.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';
import 'package:gymmerator/ui_component/product_item_card.dart';

class FavoriteProductsScreen extends StatefulWidget {
  const FavoriteProductsScreen({super.key});

  @override
  State<FavoriteProductsScreen> createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Favorite Products',
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
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: AppTextField(
                  prefixIconColor: Colors.grey,
                  hintText: 'Search products',
                  icon: Icon(Icons.search),
                  color: Colors.grey,
                )),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                itemCount: favoriteProducts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    product: favoriteProducts[index],
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

List<Product> favoriteProducts = [
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
    like: true,
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
    like: true,
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
    like: true,
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
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product5.png',
    name: 'Product 5',
    description: 'This is the description of Product 5',
    price: 290.9,
    like: true,
  ),
];
