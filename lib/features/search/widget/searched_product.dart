import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;

    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 145.h,
                width: 145.h,
              ),
              Column(
                children: [
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  Container(
                    width: 205.w,
                    padding:
                        EdgeInsets.only(left: 10.sp, top: 3.sp, bottom: 3.sp),
                    child: Stars(rating: avgRating),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      "\$ ${product.price}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: const Text("Eligible For FREE Shipping"),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
