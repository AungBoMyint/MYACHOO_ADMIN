import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertisement.freezed.dart';
part 'advertisement.g.dart';

@freezed
class Advertisement with _$Advertisement{
  factory Advertisement({
  required  String id,
  required String image,
  required String description,
  required Map<String,String> products,
  required DateTime dateTime,
  }) = _Advertisement;

  factory Advertisement.fromJson(Map<String,dynamic> json) => _$AdvertisementFromJson(json);

}