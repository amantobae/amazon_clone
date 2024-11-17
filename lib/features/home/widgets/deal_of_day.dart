import 'package:amazon_clone/features/home/services/home_service.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeService homeService = HomeService();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  fetchDealOfDay() async {
    product = await homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void naviateToProductScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () {
              naviateToProductScreen();
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    left: 10.sp,
                    top: 15.sp,
                  ),
                  child: Text(
                    "Deal of the day",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
                Image.network(
                  product!.images[0],
                  height: 235.h,
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    left: 15.sp,
                    right: 40.sp,
                    top: 5.sp,
                  ),
                  child: Text(
                    "${product!.name} ",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 19.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 100.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: product!.images
                          .map(
                            (e) => Image.network(
                              e,
                              fit: BoxFit.fitWidth,
                              width: 100.w,
                              height: 100.w,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15.sp)
                      .copyWith(left: 15.sp),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "See all deals",
                    style: TextStyle(
                      color: Colors.cyan[800],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
