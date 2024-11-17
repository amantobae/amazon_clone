import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_details_service.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product-details";
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsService productDetailsService = ProductDetailsService();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;

    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsService.addToCart(
      context: context,
      product: widget.product,
    );
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id ?? 'product id'),
                  Stars(rating: avgRating)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.sp,
                horizontal: 10.sp,
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200.h,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300.h,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: RichText(
                text: TextSpan(
                  text: "Deal Price:",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "  \$ ${widget.product.price}",
                      style: TextStyle(
                        fontSize: 23.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                widget.product.description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Container(
              color: Colors.black12,
              height: 3.h,
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: CustomButton(
                text: "Buy Now",
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AddressScreen.routeName,
                    
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: CustomButton(
                text: "Add To Cart",
                onTap: () {
                  addToCart();
                },
                color: const Color.fromRGBO(254, 216, 19, 1),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: Colors.black12,
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                "Rate The Product",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.sp),
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: GlobalVariables.secondaryColor,
                );
              },
              onRatingUpdate: (rating) {
                productDetailsService.rateProduct(
                  context: context,
                  product: widget.product,
                  rating: rating,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
