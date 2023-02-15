import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_details.g.dart';
part 'book_details.freezed.dart';

@freezed
class BookDetails with _$BookDetails {
  @Assert('reviewsPercentage.length >= 5',
      'Stars percentage should contain 5 items')
  const factory BookDetails({
    required String id,
    required String name,
    required String author,
    required String coveUrl,
    required String aboutBook,
    required double price,
    required double rate,
    required DateTime releaseDate,
    required int numReviews,
    required int numPages,
    required int numBuyers,
    required List<double> reviewsPercentage,
    required List<String> categoriesNames,
    required List<String> categoriesIds,
  }) = _BookDetails;

  factory BookDetails.fromJson(Map<String, dynamic> json) =>
      _$BookDetailsFromJson(json);
}
