import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';

import '../../../model/product.dart';
import '../../../model/view_all_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/home_category.dart';

class ViewAllController extends GetxController {
  final HomeController _homeController = Get.find();
  String status = "";
  RxList<Product> viewAllResultProducts = <Product>[].obs;
  List<String> viewAllCategories = [];
  var category = "".obs;
  RxBool isRefresh = true.obs;
  var sortPrice = SortPrice.none.obs;

  void changeSortPrice(SortPrice value) => sortPrice.value = value;

  void sortingPriceList(){
    isRefresh.value = false;
    //viewAllResultProducts.value = _homeController.viewAllModel.products;
    switch (sortPrice.value) {
      case SortPrice.lowToHigh:
        lowToHight();
        break;
      case SortPrice.highToLow:
        highToLow();
        break;
      default:
    }
    Get.back();
  }

  void refreshViewAll() {
    sortPrice.value = SortPrice.none;
    isRefresh.value = true;
    category.value = "";
    viewAllResultProducts.value = _homeController.viewAllModel.products;
  }

  void changeAllViewCategory(String value){
    isRefresh.value = false;
    category.value = value;
    viewAllResultProducts.value = _homeController.viewAllModel.products.where((element) => element.category == category.value).toList();
     (sortPrice.value == SortPrice.lowToHigh) ?  lowToHight() : 
     (sortPrice.value == SortPrice.highToLow) ?  highToLow() : null;
  }

  @override
  void onInit() {
    status = _homeController.viewAllModel.status;
    viewAllResultProducts.value = _homeController.viewAllModel.products;
    viewAllCategories = _homeController.viewAllModel.products.map((e) => e.category).toSet().toList();
    super.onInit();
  }

  void lowToHight() {
    viewAllResultProducts.sort((a,b) => a.price.compareTo(b.price));
  }

  void highToLow() {
    viewAllResultProducts.sort((a,b) => a.price.compareTo(b.price));
        viewAllResultProducts.value = viewAllResultProducts.reversed.toList();
  }
}