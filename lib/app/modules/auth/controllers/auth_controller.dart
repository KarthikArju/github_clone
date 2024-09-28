// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_clone/main.dart';
import 'package:github_signin_promax/github_signin_promax.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/shared_functions.dart';
import '../../../shared/shared_variables.dart';

class AuthController extends GetxController {
  final count = 0.obs;
  String response = '';
 

  doGithubLogin(context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return GithubSigninScreen(
        params: params,
      );
    })).then((value) async {
      response += '✅ Status: \t ${(value as GithubSignInResponse).status}\n\n';
      response += '✅ Code: \t ${(value).accessToken}\n\n';
      response += '✅ Error: \t ${(value).error}\n\n';
      await storage.write("token", value.accessToken);
      toastify("Logged in successfully");
      Get.toNamed(Routes.HOME);
    });
  }

  void increment() => count.value++;
}
