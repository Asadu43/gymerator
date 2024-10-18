import 'package:flutter/material.dart';

import '../../../../../models/api_response/Product.dart';

class PopularProductItemCard extends StatefulWidget {
  const PopularProductItemCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<PopularProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<PopularProductItemCard> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
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
                    image: AssetImage(widget.product.name!),
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
    );
  }
}
