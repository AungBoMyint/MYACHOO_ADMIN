import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/service/database.dart';

class MangeController extends GetxController {
  final Database _database = Database();
  final HomeController _homeController = Get.find();

  Future<void> delete(String path) async {
    try {
      await _database.delete(itemCollection, path: path);
      _homeController.removeItem(path);
    } catch (e) {
      print(e);
    }
  }
}
