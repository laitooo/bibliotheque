import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class CategoriesRepositories {
  Future<Result<List<Category>, CategoriesError>> getCategories();
}

class MockCategoriesRepositories extends CategoriesRepositories {
  @override
  Future<Result<List<Category>, CategoriesError>> getCategories() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        4,
        (index) => generator.category(),
      ),
    );
  }
}
