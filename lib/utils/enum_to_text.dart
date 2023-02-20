import 'package:bibliotheque/models/book_details.dart';
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

String languageToText(Language language) {
  switch (language) {
    case Language.arabic:
      return "Arabic";
    case Language.english:
      return "English";
    case Language.french:
      return "French";
    case Language.spanish:
      return "Spanish";
  }
}

String ageRangeToText(AgeRange ageRange) {
  switch (ageRange) {
    case AgeRange.fiveUp:
      return "Ages 5 & Up";
    case AgeRange.eightUp:
      return "Ages 8 & Up";
    case AgeRange.thirteenUp:
      return "Ages 13 & Up";
    case AgeRange.eighteenUp:
      return "Ages 18 & Up";
    case AgeRange.twentyUp:
      return "Ages 20 & Up";
  }
}
