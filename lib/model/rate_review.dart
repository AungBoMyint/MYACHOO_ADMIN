import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_review.freezed.dart';
part 'rate_review.g.dart';

@freezed
class RateReview with _$RateReview{
  factory RateReview({
    required int rate,
    required String review,
    required String userID,
    required DateTime dateTime,
  }) = _RateReview;

  factory RateReview.fromJson(Map<String,dynamic> json) => _$RateReviewFromJson(json);
}