import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
  }

  void navigateToAddressScreen(num sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;
    user.cart
        .map(
          (e) => sum += e["quantity"] * e['product']["price"] as num,
        )
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42.h,
                  margin: EdgeInsets.only(left: 15.sp),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.r),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.sp),
                            child: Icon(
                              Icons.search,
                              size: 23.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.r)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.r)),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1.w,
                          ),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42.h,
                margin: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Icon(
                  Icons.mic,
                  size: 23.sp,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: CustomButton(
                color: Colors.yellow[600],
                text: "Proceed to buy ${user.cart.length} items",
                onTap: () {
                  if (user.cart.isEmpty) {
                    showSnackBar(context, "Your cart is empty");
                  } else {
                    navigateToAddressScreen(sum);
                  }
                },
              ),
            ),
            SizedBox(height: 15.h),
            Container(
              color: Colors.black12,
              height: 1,
            ),
            SizedBox(height: 10.h),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
