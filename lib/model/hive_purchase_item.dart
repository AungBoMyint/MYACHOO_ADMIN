import 'package:hive/hive.dart';

part 'hive_purchase_item.g.dart';

@HiveType(typeId: 5)
class HivePurchaseItem {
  @HiveField(0)
  String itemName;
  @HiveField(1)
  int count;
  @HiveField(2)
  String? size;
  @HiveField(3)
  String? color;
  @HiveField(4)
  int price;
  @HiveField(5)
  int? discountPrice;
  @HiveField(6)
  int? requirePoint;
  HivePurchaseItem({
    required this.itemName,
    required this.count,
    required this.size,
    required this.color,
    required this.price,
    required this.discountPrice,
    required this.requirePoint,
  });
}
