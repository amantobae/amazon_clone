import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_service.dart';
import 'package:amazon_clone/features/search/widget/searched_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async {
    products = await searchServices.fetchSearchedProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.routeName,
                          arguments: products![index],
                        ),
                        child: SearchedProduct(
                          product: products![index],
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
