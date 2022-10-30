import 'package:get/get.dart';

class HelperController extends GetxController {
  bool isNumeric(String x) {
    if (x == null) {
      return false;
    }
    return double.parse(x, (e) => null!) != null;
  }
}
