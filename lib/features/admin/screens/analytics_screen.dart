import 'dart:developer';

import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:amazon_clone/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  num? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminService.getEarnings(context);
    totalSales = earningData["totalEarnings"];
    earnings = earningData["sales"];
    if (mounted) {
      setState(() {});
      log(totalSales.toString());
      log(earnings.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final a = earnings?.isEmpty == false ? earnings![0].earning : 0;
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              InkWell(
                onTap: () {
                  log(a.toString());
                },
                child: Text(
                  "\$$totalSales",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                child: GraphChart(
                  seriesList: [
                    Sales('Mobiles', a),
                    Sales('Essentials', a),
                    Sales('Books', a),
                    Sales('Appliances', a),
                    Sales('Fashion', a),
                  ],
                ),
              ),
            ],
          );
  }
}
