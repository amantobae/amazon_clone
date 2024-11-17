import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/below_appbar.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/amazon_in.png",
                    width: 120.w,
                    height: 45.h,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15.sp),
                        child: const Icon(Icons.notifications_outlined),
                      ),
                      const Icon(Icons.search),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          SizedBox(height: 15.h),
          const TopButtons(),
          SizedBox(height: 15.h),
          const Orders(),
        ],
      ),
    );
  }
}
