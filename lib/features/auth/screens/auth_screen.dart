import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Auth {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService authService = AuthService();

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    "Create an account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: const BoxDecoration(
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Form(
                      key: signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: nameController,
                            hintText: 'Name',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextfield(
                            controller: emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextfield(
                            controller: passwordController,
                            hintText: 'Password',
                          ),
                          SizedBox(height: 10.h),
                          CustomButton(
                            text: "Sign Up",
                            onTap: () {
                              if (signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: Text(
                    "Sign in",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: const BoxDecoration(
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Form(
                      key: signInFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          CustomTextfield(
                            controller: emailController,
                            hintText: 'Email',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextfield(
                            controller: passwordController,
                            hintText: 'Password',
                          ),
                          SizedBox(height: 10.h),
                          CustomButton(
                            text: "Sign in",
                            onTap: () {
                              if (signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          )
                        ],
                      ),
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
