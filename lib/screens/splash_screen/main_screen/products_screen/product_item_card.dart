import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymmerator/screens/splash_screen/main_screen/products_screen/product_details_screen/product_details_screen.dart';
import 'package:gymmerator/utils/nav/nav.dart';

import '../../../../bloC/auth_cubit/featured_product_cubit/featured_product_cubit.dart';
import '../../../../models/api_response/Product.dart';
import '../../../../utils/api_constants/api_constants.dart';

class ProductItemCard extends StatefulWidget {
  const ProductItemCard({
    super.key,
    required this.product,
    this.show,
  });
  final Product product;
  final bool? show;

  @override
  State<ProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                  height: screenHeight * 0.178,
                  width: screenWidth * 3,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "${ApiConstants.baseUrl}/product/image/${widget.product.images?.first}"),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(0.5, 0.5),
                      )
                    ],
                  )),
              widget.show == false
                  ? const SizedBox()
                  : Positioned(
                      right: 8.0,
                      top: 8.0,
                      child: widget.product.isFavorite == true
                          ? IconButton(
                              onPressed: () {
                                context
                                    .read<FeaturedProductCubit>()
                                    .removeRequest(id: widget.product.id!);
                              },
                              icon:
                                  const Icon(Icons.favorite, color: Colors.red))
                          : IconButton(
                              onPressed: () {
                                context
                                    .read<FeaturedProductCubit>()
                                    .addToFavoriteRequest(
                                        id: widget.product.id!);
                              },
                              icon: const Icon(Icons.favorite_border)))
            ],
          ),
          const SizedBox(height: 8.0),
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
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\$${widget.product.price.toString()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.product.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.vazirmatn(),
                )),
          ),
        ],
      ),
    );
  }
}
