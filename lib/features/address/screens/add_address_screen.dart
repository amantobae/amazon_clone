import 'dart:developer';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  static const String routeName = "/add-address";
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddressService addressService = AddressService();

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String addressToBeUsed = '';
  final addressFormKey = GlobalKey<FormState>();

  void submitAddress(String addressFromProvider) {
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
    addressService.saveUserAddress(context: context, address: addressToBeUsed);
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
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
                SizedBox(height: 10.h),
                Center(
                  child: CustomButton(
                    text: "Submit Address",
                    onTap: () {
                      submitAddress(addressToBeUsed);
                    },
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
