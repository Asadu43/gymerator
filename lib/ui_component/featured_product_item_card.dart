import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  height: 0.19.sh,
                  width: 0.33.sw,
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
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
                      )
                    ],
                  )),
              Positioned(
                  right: 1.w,
                  top: 2.h,
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
          SizedBox(height: 0.01.sh),
          SizedBox(
            width: 0.4.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                widget.product.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.w600,fontSize: 9.sp),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "\$${widget.product.price.toString()}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(color: Colors.grey,fontSize: 10.sp,fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
