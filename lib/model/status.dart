import 'package:freezed_annotation/freezed_annotation.dart';

part 'status.freezed.dart';
part 'status.g.dart';

@freezed
class Status with _$Status{
  factory Status({
    required String name,
    required String id,
    required DateTime dateTime,
  }) = _Status;

  factory Status.fromJson(Map<String,dynamic> json) => _$StatusFromJson(json);
}