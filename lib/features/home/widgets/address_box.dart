import 'package:amazon_clone/features/address/screens/add_address_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    void navigateToAddAddressScreen() {
      Navigator.pushNamed(context, AddAddressScreen.routeName);
    }

    return InkWell(
      onTap: () {
        navigateToAddAddressScreen();
      },
      child: Container(
        height: 40.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 226, 221),
              Color.fromARGB(255, 162, 236, 233),
            ],
            stops: [
              0.5,
              1.0,
            ],
          ),
        ),
        padding: EdgeInsets.only(
          left: 10.sp,
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 23.sp,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 5.sp),
                child: Text(
                  "Delivery to ${user.name} - ${user.address}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.sp, top: 2.sp),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: 23.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
