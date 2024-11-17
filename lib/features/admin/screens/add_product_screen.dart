import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final AdminService adminService = AdminService();

  List<File> images = [];

  String category = "Mobiles";

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  final addProductFormKey = GlobalKey<FormState>();

  void selectImages() async {
    var res = await pickImages();

    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminService.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: addProductFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200.h,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200.h,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          selectImages();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10.r),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 35.sp,
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  "Select Product Images",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey.shade400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 30.h),
                CustomTextfield(
                  controller: productNameController,
                  hintText: "Product Name",
                ),
                SizedBox(height: 10.h),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                SizedBox(height: 10.h),
                CustomTextfield(controller: priceController, hintText: "Price"),
                SizedBox(height: 10.h),
                CustomTextfield(
                    controller: quantityController, hintText: "Quantity"),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        category = value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(text: "Sell", onTap: sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
