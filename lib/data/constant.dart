import 'package:flutter/material.dart';

const Color scaffoldBackground = Colors.white;
const Color appBarColor = Colors.white;
const Color appBarTitleColor = Color.fromRGBO(19, 19, 19, 1);
const Color homeIndicatorColor = Colors.orangeAccent;
const Color detailBackgroundColor = Colors.white;
const Color detailTextBackgroundColor = Colors.white;
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
);

const String baseUrl = 'http://192.168.1.5:5000/api/v1/streaming/movie/';
const String profileUrl = 'profile/';
const String itemUrl = 'item/';

const String userCollection = 'users';
const String profileCollection = 'profiles';
const String itemCollection = 'items';
const String purchaseCollection = 'purchases';
const String brandCollection = 'brandProducts';
const String categoryCollection = 'categories';
const String statusCollection  = 'statusCollection';
const String advertisementCollection = 'advertisementCollection';
const String tagsCollection = 'tagsCollection';
const String adminUserCollection = 'adminUserCollection';
/*const List<String> priceList = [
  '၁ ထည် လက်လီ ဈေးနှုန်း',
  'လက်ကား ဈေးနှုန်း',
];*/
const String boxName = "favouritesBOXes";


///////////////
const String hotSale = "Hot Sales";
const String limitedEditionTag = "LIMITED EDITION";
const String rewardStatus = "Beauty Insider Rewards";

//
const String forRewardProducts = "For Reward Products";
const String forNewProducts = "For New Products";

const String purchaseBox = "purchasesBoxs";

const List<String> mainCategoryList=[
  "တရုတ်",
  "ယိုးဒယား",
  "အိန္ဒိယ",
];

