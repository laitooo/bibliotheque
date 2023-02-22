import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/repos/search_repo.dart';

class FilterOptions {
  final SortingMethod sortingMethod;
  final int startPrice, endPrice;
  final RatingRange ratingRange;
  final List<Category> categories;
  final Language language;
  final AgeRange ageRange;

  FilterOptions({
    required this.sortingMethod,
    required this.startPrice,
    required this.endPrice,
    required this.ratingRange,
    required this.categories,
    required this.language,
    required this.ageRange,
  });

  factory FilterOptions.emptyFilter() => FilterOptions(
        sortingMethod: SortingMethod.trending,
        startPrice: 4,
        endPrice: 32,
        ratingRange: RatingRange.all,
        categories: [],
        language: Language.all,
        ageRange: AgeRange.all,
      );

  @override
  String toString() {
    return "sort: " +
        sortingMethod.name +
        "\n" +
        "start price: $startPrice" +
        "\n" +
        "end price: $endPrice" +
        "\n" +
        "rating: $ratingRange" +
        "\n" +
        "language: $language" +
        "\n" +
        "age: $ageRange" +
        "\n" +
        "categories: $categories";
  }
}
