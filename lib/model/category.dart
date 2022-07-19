import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category{
  factory Category({
    required String name,
    required String id,
    @JsonKey(nullable: true,defaultValue: "")
    String? mainId,
    @JsonKey(nullable: true, defaultValue: "")
    String? image,
    required DateTime dateTime,
  }) = _Category;

  factory Category.fromJson(Map<String,dynamic> json) => _$CategoryFromJson(json);
}