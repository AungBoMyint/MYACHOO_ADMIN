import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_rate_review.freezed.dart';
part 'main_rate_review.g.dart';

@freezed
class RateReview with _$RateReview{
  @JsonSerializable(explicitToJson: true)
  factory RateReview({
    @JsonKey(nullable: true,defaultValue: [])
    required List<RateReview> data,
  }) = _RateReview;

  factory RateReview.fromJson(Map<String,dynamic> json) => _$RateReviewFromJson(json);
}