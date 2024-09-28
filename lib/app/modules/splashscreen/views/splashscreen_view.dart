// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
     final SplashscreenController controller = Get.put(SplashscreenController());
    return Scaffold();
  }
}
