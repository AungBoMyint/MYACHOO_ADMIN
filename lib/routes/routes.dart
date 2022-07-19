import 'package:get/route_manager.dart';
import 'package:kozarni_ecome/binding/upload_binding.dart';
import 'package:kozarni_ecome/screen/advertisement/view/advertisement_screen.dart';
import 'package:kozarni_ecome/screen/blue_tooth_screen.dart';
import 'package:kozarni_ecome/screen/cart.dart';
import 'package:kozarni_ecome/screen/check_out_screen.dart';
import 'package:kozarni_ecome/screen/detail_screen.dart';
import 'package:kozarni_ecome/screen/home_screen.dart';
import 'package:kozarni_ecome/screen/item_upload_screen.dart';
import 'package:kozarni_ecome/screen/manage_item.dart';
import 'package:kozarni_ecome/screen/product_category/view/product_category_view.dart';
import 'package:kozarni_ecome/screen/search_screen.dart';
import 'package:kozarni_ecome/screen/status/status_screen.dart';
import 'package:kozarni_ecome/screen/tags/tags_screen.dart';
import 'package:kozarni_ecome/screen/user_order_view.dart';
import 'package:kozarni_ecome/screen/view/favourite.dart';
import 'package:kozarni_ecome/screen/view_all/view/view_all.dart';

import '../intro_screen.dart';

const String introScreen = '/intro-screen';
const String homeScreen = '/home';
const String checkOutScreen = '/checkout';
const String detailScreen = '/detail';
const String uploadItemScreen = '/uploadItemScreen';
const String mangeItemScreen = '/manage-item';
const String purchaseScreen = '/purchase-screen';
const String blueToothScreen = '/bluetooth-screen';
const String searchScreen = '/searchScreen';
const String advertisementUrl = '/advertisement';
const String categoriesUrl = '/categories';
const String statusUrl = '/status';
const String tagsUrl = '/tags';
const String viewAllUrl = '/view_all';
const String cartUrl = '/cart_url';
const String favouriteUrl = '/favourite';

List<GetPage> routes = [
  GetPage(
    name: introScreen,
    page: () => OnBoardingPage(),
  ),
  GetPage(
    name: homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: checkOutScreen,
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: detailScreen,
    page: () => DetailScreen(),
  ),
  GetPage(
    name: uploadItemScreen,
    page: () => UploadItem(),
    binding: UploadBinding(),
  ),
  GetPage(
    name: purchaseScreen,
    page: () => UserOrderView(),
  ),
  GetPage(
    name: blueToothScreen,
    page: () => BlueToothPrintScreen(),
  ),
  GetPage(
    name: searchScreen,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: advertisementUrl,
    page: () => AdvertisementScreen(),
  ),
  GetPage(
    name: statusUrl,
    page: () => StatusScreen(),
  ),
  GetPage(
    name: categoriesUrl,
    page: () => ProductCategoryView(),
  ),
  GetPage(
    name: tagsUrl,
    page: () => TagsScreen(),
  ),
  GetPage(
    name: viewAllUrl,
    page: () => ViewAllScreen(),
  ),
  GetPage(
    name: cartUrl,
    page: () => CartView(),
  ),
  GetPage(
    name: mangeItemScreen,
    page: () => ManageItem(),
  ),
  GetPage(
    name: favouriteUrl,
    page: () => FavouriteView(),
  ),
];
