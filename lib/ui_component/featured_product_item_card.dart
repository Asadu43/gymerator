import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/product_details_screen/product_details_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';

import '../bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import '../models/api_response/Product.dart';
import '../utils/api_constants/api_constants.dart';

class FeaturedProductItemCard extends StatefulWidget {
  const FeaturedProductItemCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<FeaturedProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<FeaturedProductItemCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (widget.product.id != null) {
          Nav.push(context, ProductDetailsScreen(id: widget.product.id!));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  height: screenHeight * 0.19,
                  width: screenWidth * 0.33,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${ApiConstants.baseUrl}/product/image/${widget.product.images?.first}"),
                      fit: BoxFit.fitHeight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.5,
                        spreadRadius: 0.0,
                        offset: Offset(1.0, 1.0),
                      )
                    ],
                  )),
              Positioned(
                  right: 4.0,
                  top: 8.0,
                  child: widget.product.isFavorite == true
                      ? IconButton(
                          onPressed: () {
                            context
                                .read<FeaturedProductCubit>()
                                .removeRequest(id: widget.product.id!);
                          },
                          icon: const Icon(Icons.favorite, color: Colors.red))
                      : IconButton(
                          onPressed: () {
                            context
                                .read<FeaturedProductCubit>()
                                .addToFavoriteRequest(id: widget.product.id!);
                          },
                          icon: const Icon(Icons.favorite_border)))
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.product.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "\$${widget.product.price.toString()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
