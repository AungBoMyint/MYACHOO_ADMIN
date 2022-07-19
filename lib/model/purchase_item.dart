import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_item.freezed.dart';
part 'purchase_item.g.dart';

@freezed
class PurchaseItem with _$PurchaseItem{
  factory PurchaseItem({
    required String id, 
    required String itemName, 
    required int count, 
    @JsonKey(nullable: true)
     String? size, 
     @JsonKey(nullable: true)
     String? color,
    required int price,
    @JsonKey(nullable: true)
   int? discountPrice,
   @JsonKey(nullable: true)
   int? requirePoint,
    }) = _PurchaseItem;
    factory PurchaseItem.fromJson(Map<String,dynamic> json) => _$PurchaseItemFromJson(json);
}