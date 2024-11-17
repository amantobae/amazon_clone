import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_service.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final HomeService homeService = HomeService();
  List<Product>? productList;
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeService.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
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
            title: Text(
              widget.category,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.sp,
                    vertical: 10.sp,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep showing for ${widget.category}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170.h,
                  child: GridView.builder(
                    padding: EdgeInsets.only(left: 15.sp),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10.sp,
                    ),
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsScreen.routeName,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 146.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: 0,
                                top: 5.sp,
                                right: 15.sp,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
