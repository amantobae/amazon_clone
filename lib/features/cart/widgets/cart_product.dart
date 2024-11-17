import 'package:amazon_clone/features/cart/services/cart_service.dart';
import 'package:amazon_clone/features/product_details/services/product_details_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsService productDetailsService = ProductDetailsService();
  final CartService cartService = CartService();

  void increaseQuantity(Product product) {
    productDetailsService.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartService.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart["product"]);
    final quantity = productCart["quantity"];

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 145.h,
                width: 145.h,
              ),
              Column(
                children: [
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      product.name,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      "\$ ${product.price}",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: const Text("Eligible For FREE Shipping"),
                  ),
                  Container(
                    width: 205.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: const Text(
                      "In Stock",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        decreaseQuantity(product);
                      },
                      child: Container(
                        width: 35.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.remove,
                          size: 18,
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Container(
                        width: 35.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        increaseQuantity(product);
                      },
                      child: Container(
                        width: 35.w,
                        height: 32.h,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
