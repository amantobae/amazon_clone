import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.white,
        ),
        child: Container(
          width: 180.w,
          padding: EdgeInsets.all(10.sp),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180.w,
          ),
        ),
      ),
    );
  }
}
