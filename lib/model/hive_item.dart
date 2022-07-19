import 'dart:core';

import 'package:hive/hive.dart';

part 'hive_item.g.dart';

@HiveType(typeId: 8)
class HiveItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String photo1;
  @HiveField(2)
  final String photo2;
  @HiveField(3)
  final String photo3;
  @HiveField(4)
  final String name;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final int price;
  @HiveField(7)
  final int discountPrice;
  @HiveField(8)
   String? size;
  @HiveField(9)
   String? color;
  @HiveField(10)
  final int requirePoint;
  @HiveField(11)
  String? advertisementID;
  @HiveField(12)
  final String status;
  @HiveField(13)
  final String category;
  @HiveField(14)
  final List<String> tags;
  @HiveField(15)
  final DateTime dateTime;
  @HiveField(16)
  String? deliveryTime;
  @HiveField(17)
  final int love;
  @HiveField(18)
  final List<String> comment;
  @HiveField(19)
  final String brandName;
  HiveItem({
    required this.id,
    required this.name,
    required this.photo1,
    required this.photo2,
    required this.photo3,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.size,
    required this.color,
    required this.requirePoint,
    required this.advertisementID,
    required this.category,
    required this.status,
    required this.tags,
    required this.comment,
    required this.dateTime,
    required this.deliveryTime,
    required this.love,
    required this.brandName,
  });
}
