import 'package:bibliotheque/models/book.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_details.g.dart';
part 'book_details.freezed.dart';

enum AgeRange {
  all,
  fiveUp,
  eightUp,
  thirteenUp,
  eighteenUp,
  twentyUp,
}

enum Language {
  all,
  arabic,
  english,
  french,
  spanish,
}

@freezed
class BookDetails with _$BookDetails {
  const BookDetails._();

  @Assert('reviewsPercentage.length >= 5',
      'Stars percentage should contain 5 items')
  const factory BookDetails({
    required String id,
    required String name,
    required String authorId,
    required String authorName,
    required String publisherId,
    required String publisherName,
    required String isbn,
    required String coveUrl,
    required String aboutBook,
    required double price,
    required double rate,
    required AgeRange age,
    required Language language,
    required DateTime publishDate,
    required int numReviews,
    required int numPages,
    required int numBuyers,
    required List<double> reviewsPercentage,
    required List<String> categoriesNames,
    required List<String> categoriesIds,
  }) = _BookDetails;

  factory BookDetails.fromJson(Map<String, dynamic> json) =>
      _$BookDetailsFromJson(json);

  Book toBook() => Book(
        id: id,
        name: name,
        coveUrl: coveUrl,
        price: price,
        rate: rate,
        categoriesNames: categoriesNames,
        categoriesIds: categoriesIds,
      );
}
