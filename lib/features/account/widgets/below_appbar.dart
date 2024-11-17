import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: EdgeInsets.only(
        left: 10.sp,
        right: 10.sp,
        bottom: 10.sp,
      ),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "Hello, ",
              style: TextStyle(
                fontSize: 22.sp,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
