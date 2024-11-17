import 'dart:developer';

import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_service.dart';
import 'package:amazon_clone/payment_configurations.dart'
    as payment_configurations;
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final AddressService addressService = AddressService();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String addressToBeUsed = '';
  final addressFormKey = GlobalKey<FormState>();

  final List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: "total amount",
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
  }

  void onApplePayResult(paymentResult) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressService.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressService.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );

    debugPrint("Apple Pay Result: $paymentResult");
  }

  void onGooglePayResult(paymentResult) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressService.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressService.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
    debugPrint("Google Pay Result: $paymentResult");
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pinCodeController.text}";
      } else {
        throw Exception("Please Enter All values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }
    log(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: Form(
            key: addressFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (address.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Text(
                            address,
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Or",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                CustomTextfield(
                  controller: flatBuildingController,
                  hintText: 'Flat, House Number',
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  controller: areaController,
                  hintText: 'Area, Street',
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  controller: pinCodeController,
                  hintText: 'Pin Code',
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  controller: cityController,
                  hintText: 'Town/City',
                ),
                SizedBox(height: 20.h),
                Text(
                  "Choose Payment Method",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Column(
                    children: [
                      GooglePayButton(
                        onPressed: () {
                          payPressed(address);
                        },
                        width: double.infinity,
                        height: 50.h,
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                payment_configurations.defaultGooglePay),
                        paymentItems: paymentItems,
                        type: GooglePayButtonType.order,
                        margin: EdgeInsets.only(top: 15.sp),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      ApplePayButton(
                        onPressed: () {
                          payPressed(address);
                        },
                        width: double.infinity,
                        height: 50.h,
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                                payment_configurations.defaultApplePay),
                        paymentItems: paymentItems,
                        type: ApplePayButtonType.order,
                        margin: EdgeInsets.only(top: 15.sp),
                        onPaymentResult: onApplePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
