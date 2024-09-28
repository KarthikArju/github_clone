// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:github_clone/app/shared/shared_functions.dart';
import 'package:github_clone/app/shared/shared_variables.dart';
import 'package:github_clone/app/widgets/app_images.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: ListView(
          children: [
            setHeight(58),
            Image.asset(
              AppImages.githubLogo,
              height: 83,
            ),
            setHeight(40),
            Image.asset(
              AppImages.loginBG,
              height: 200,
              fit: BoxFit.contain,
            ),
            setHeight(40),
            Center(
                child: Text(
              "Lets Build from here...",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            )),
            setHeight(9),
            Text(
              "Our platform drives innovation with tools that boost developer velocity",
              style: TextStyle(
                  color: Color(0xff5F607E),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            setHeight(100),
            MaterialButton(
              onPressed: () {
                controller.doGithubLogin(context);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Center(
                  child: Text(
                    "Signup with Github",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            setHeight(50),
          ],
        ),
      ),
    );
  }
}
