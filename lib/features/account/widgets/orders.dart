import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/services/account_services.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchUserOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15.sp),
                      child: Text(
                        "Your Orders",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 170.h,
                  padding: EdgeInsets.only(
                    left: 10.sp,
                    top: 20.sp,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetailsScreen.routeName,
                            arguments: orders![index],
                          );
                        },
                        child: SingleProduct(
                            image: orders![index].products[0].images[0]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
