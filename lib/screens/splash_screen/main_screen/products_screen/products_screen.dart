import 'package:flutter/material.dart';
import 'package:gymmerator/ui_component/app_drawer.dart';
import 'package:gymmerator/ui_component/app_textfield.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Hi, Noah!'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AppTextField(
                      hintText: 'Search products',
                      icon: Icon(Icons.search),
                      color: Colors.grey,
                    )),
                const SizedBox(height: 16.0),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Featured Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredProducts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductItemCard(
                        product: featuredProducts[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Most Popular Products',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularProducts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductItemCard(
                        product: featuredProducts[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 150,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8.0),
              Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(product.description),
            ],
          ),
        ),
        Positioned(
            right: 8.0,
            top: 8.0,
            child: Icon(
              product.like ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ))
      ],
    );
  }
}

class Product {
  final String imageUrl;
  final String name;
  final String description;
  final bool like;

  Product({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.like,
  });
}

List<Product> featuredProducts = [
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    like: false,
  ),
  Product(
    imageUrl: 'assets/images/product1.png',
    name: 'Product 1',
    description: 'This is the description of Product 1',
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product2.png',
    name: 'Product 2',
    description: 'This is the description of Product 2',
    like: false,
  ),
];

List<Product> popularProducts = [
  Product(
    imageUrl: 'assets/images/product3.png',
    name: 'Product 3',
    description: 'This is the description of Product 3',
    like: true,
  ),
  Product(
    imageUrl: 'assets/images/product4.png',
    name: 'Product 4',
    description: 'This is the description of Product 4',
    like: false,
  ),
  // Add more popular products here...
];
