import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const AccountButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.white,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r))),
          onPressed: ontap,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
