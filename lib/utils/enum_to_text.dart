import 'package:bibliotheque/models/question.dart';

String questionToText(QuestionType type) {
  switch (type) {
    case QuestionType.general:
      return "General";
    case QuestionType.account:
      return "Account";
    case QuestionType.service:
      return "Service";
    case QuestionType.book:
      return "Books";
    case QuestionType.payment:
      return "Payment";
    case QuestionType.others:
      return "Others";
  }
}
