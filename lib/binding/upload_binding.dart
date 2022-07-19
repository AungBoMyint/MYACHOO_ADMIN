import 'package:get/instance_manager.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadController());
  }
}
