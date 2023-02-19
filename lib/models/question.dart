import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.g.dart';
part 'question.freezed.dart';

enum QuestionType {
  general,
  account,
  service,
  book,
  payment,
  others,
}

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String question,
    required String answer,
    required QuestionType type,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
