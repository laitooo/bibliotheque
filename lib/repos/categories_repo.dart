import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class CategoriesRepositories {
  Future<Result<List<Category>, CategoriesError>> getTopCategories();
  Future<Result<List<Category>, CategoriesError>> getAllCategories();
}

class MockCategoriesRepositories extends CategoriesRepositories {
  @override
  Future<Result<List<Category>, CategoriesError>> getTopCategories() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(CategoriesError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 5,
        (index) => generator.category(),
      ),
    );
  }

  @override
  Future<Result<List<Category>, CategoriesError>> getAllCategories() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(CategoriesError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 20,
        (index) => generator.category(
          index: index.toString(),
        ),
      ),
    );
  }
}
