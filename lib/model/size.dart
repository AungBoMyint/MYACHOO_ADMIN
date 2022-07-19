import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'size.freezed.dart';
part 'size.g.dart';

@freezed
class Size with _$Size {
  factory Size({
    required String id,
    required String size,
    required String price,
  }) = _Size;
  factory Size.empty() => Size(id: Uuid().v1(), size: "", price: "");
  factory Size.fromJson(Map<String,dynamic> json) => _$SizeFromJson(json);
}