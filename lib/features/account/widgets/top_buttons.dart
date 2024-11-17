import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  AccountServices accountServices = AccountServices();
  void logOut() {
    accountServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              ontap: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              ontap: () {},
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            AccountButton(
              text: "Log Out",
              ontap: () {
                logOut();
              },
            ),
            AccountButton(
              text: "Your Wish List",
              ontap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
