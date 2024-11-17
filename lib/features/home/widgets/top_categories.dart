import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryDealsScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 83,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
                context, GlobalVariables.categoryImages[index]["title"]!),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      height: 40.h,
                      width: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
