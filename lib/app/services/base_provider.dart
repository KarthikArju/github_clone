import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  BaseProvider() {
    // .........................Development Environment.........................
    httpClient.baseUrl = 'https://api.github.com/';
    
    httpClient.timeout = const Duration(seconds: 15);
  }
}
