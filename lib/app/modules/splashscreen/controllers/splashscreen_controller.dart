import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  checkToken() async {
    var token = await storage.read("token");
    if (token != null) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.AUTH);
    }
  }
}
