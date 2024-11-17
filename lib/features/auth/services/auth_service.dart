import 'dart:convert';
import 'dart:developer';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user func
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        token: "",
        email: email,
        cart: [],
        name: name,
        id: '',
        password: password,
        type: '',
        address: '',
      );
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () {
              showSnackBar(context,
                  "Account has been created ! \nLogin with the same credentials");
            });
      }
      log(res.body);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "$e");
      }
    }
  }

  // sign in user func
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (context.mounted) {
        httpErrorHandle(
            response: res,
            context: context,
            onSuccess: () async {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(res.body);
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                'x-auth-token',
                jsonDecode(res.body)['token'],
              );
            });
        log(res.body);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "$e");
      }
    }
  }

  // get user data func
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      log("token received $token");

      if (token == null) {
        log("token: $token");
        prefs.setString("x-auth-token", "");
      }

      var tokenRes = await http.post(
        Uri.parse("$uri/isTokenValid"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token
          },
        );
        log("userResponse body: ${userResponse.body}");
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "$e");
      }
    }
  }
}
