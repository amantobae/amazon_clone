import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;
    user.cart
        .map(
          (e) => sum += e["quantity"] * e['product']["price"] as num,
        )
        .toList();
    return Container(
      margin: EdgeInsets.all(10.sp),
      child: Row(
        children: [
          Text(
            'Subtotal ',
            style: TextStyle(fontSize: 20.sp),
          ),
          Text(
            '\$$sum',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
