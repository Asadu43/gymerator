import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../bloC/auth_cubit/all_favorite_product_cubit/all_favorite_products_cubit.dart';
import '../../../../../models/api_response/Product.dart';
import '../../../../../utils/api_constants/api_constants.dart';
import '../../../../../utils/nav/nav.dart';
import '../product_details_screen/product_details_screen.dart';

class FavoriteProductItemCard extends StatefulWidget {
  const FavoriteProductItemCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<FavoriteProductItemCard> createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<FavoriteProductItemCard> {
  @override
  Widget build(BuildContext context) {
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
                height: 0.178.sh,
                width: 0.5.sw,
                margin:EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.network(
                    "${ApiConstants.baseUrl}/product/image/${widget.product.images?.first}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('Please Wait'),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                  right: 8.w,
                  top: 8.h,
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        context
                            .read<AllFavoriteProductsCubit>()
                            .removeRequest(id: widget.product.id!);
                      });
                    },
                    child: const Icon(Icons.favorite, color: Colors.red),
                  ))
            ],
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 0.4.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                widget.product.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.w600,fontSize: 14.sp),
              ),
            ),
          ),
          SizedBox(
            width: 0.4.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "\$${widget.product.price.toString()}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.vazirmatn(fontWeight: FontWeight.w600,color: Colors.grey,),
              ),
            ),
          ),
          SizedBox(
            width: 0.4.sw,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  widget.product.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.vazirmatn(fontSize: 8.sp,color: Colors.grey),
                )),
          ),
        ],
      ),
    );
  }
}
