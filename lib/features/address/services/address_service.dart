import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressService {
  void saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({"address": address}),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            log(res.body);
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)["address"]);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/order"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({
          "cart": userProvider.user.cart,
          "address": address,
          "totalPrice": totalSum
        }),
      );
      if (context.mounted) {
        httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Order has been placed !");
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
