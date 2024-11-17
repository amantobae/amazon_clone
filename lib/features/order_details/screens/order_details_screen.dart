import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final AdminService adminService = AdminService();

  void navigateToSearchScreen(String query) {
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    }
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  void changeOrderStatus(int status) {
    adminService.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

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
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View order details",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Order Date:",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                    widget.order.orderedAt)
                                .add(const Duration(hours: 6)),
                          ),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Order ID:",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        const Spacer(),
                        Text(
                          widget.order.id,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Total Price:",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        const Spacer(),
                        Text(
                          "\$ ${widget.order.totalPrice}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "View order details",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.order.products
                        .map(
                          (product) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                product.images[0],
                                fit: BoxFit.contain,
                                width: 130.w,
                                height: 130.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Quantity: ${widget.order.quantity[0]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
              SizedBox(height: 10.h),
              Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                ),
              ),
              Stepper(
                controlsBuilder: (context, details) {
                  if (user.type == "Admin" && currentStep < 3) {
                    return CustomButton(
                      text: "Done",
                      onTap: () {
                        changeOrderStatus(details.currentStep);
                      },
                    );
                  }
                  return const SizedBox();
                },
                currentStep: currentStep,
                steps: [
                  Step(
                    title: Text("Pending", style: TextStyle(fontSize: 17.sp)),
                    content: Text(
                      "Order has not been delivered yet",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Completed", style: TextStyle(fontSize: 17.sp)),
                    content: Text(
                      "Order has been delivered, you have to sign it",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    isActive: currentStep > 1,
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Delivered", style: TextStyle(fontSize: 17.sp)),
                    content: Text(
                      "Order has been delivered",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    isActive: currentStep > 2,
                    state: currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Received", style: TextStyle(fontSize: 17.sp)),
                    content: Text(
                      user.type == "Admin"
                          ? "Customer has received his order"
                          : "You have received your order",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
