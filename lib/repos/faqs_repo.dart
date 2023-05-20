import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class FAQsRepository {
  Future<Result<List<Question>, FAQError>> loadFAQs(QuestionType type);
}

class MockFAQsRepository extends FAQsRepository {
  @override
  Future<Result<List<Question>, FAQError>> loadFAQs(QuestionType type) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(FAQError.networkError);
    }

    return Result.value(List.generate(5, (index) => generator.faq()));
  }
}
