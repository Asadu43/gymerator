import 'package:flutter/material.dart';

import '../../../../../models/api_response/Product.dart';
import '../../../../../utils/api_constants/api_constants.dart';
import '../../../../../utils/nav/nav.dart';
import '../product_details_screen/product_details_screen.dart';

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
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                  )),
              // Positioned(
              //     right: 8.0,
              //     top: 8.0,
              //     child: InkWell(
              //       onTap: () {
              //         setState(() {
              //           widget.product = !widget.product.like;
              //         });
              //       },
              //       child: widget.product.like
              //           ? const Icon(Icons.favorite, color: Colors.red)
              //           : const Icon(Icons.favorite_border, color: Colors.black),
              //     ))
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
                style: const TextStyle(fontWeight: FontWeight.bold),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(widget.product.description!,
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
