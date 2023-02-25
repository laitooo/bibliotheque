import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/repos/search_repo.dart';

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
    case AgeRange.all:
      return "All";
  }
}

String starsNumberToText(StarsNumber starsNumber) {
  switch (starsNumber) {
    case StarsNumber.oneStar:
      return "1";
    case StarsNumber.twoStars:
      return "2";
    case StarsNumber.threeStars:
      return "3";
    case StarsNumber.fourStars:
      return "4";
    case StarsNumber.fiveStars:
      return "5";
  }
}

String sortingMethodToText(SortingMethod sortingMethod) {
  switch (sortingMethod) {
    case SortingMethod.trending:
      return "Trending";
    case SortingMethod.newReleases:
      return "New Releases";
    case SortingMethod.highestRating:
      return "Highest Rating";
    case SortingMethod.lowestRating:
      return "Lowest Rating";
    case SortingMethod.highestPrice:
      return "Highest price";
    case SortingMethod.lowestPrice:
      return "Lowest price";
  }
}

String ratingRangeToText(RatingRange ratingRange) {
  switch (ratingRange) {
    case RatingRange.all:
      return "All";
    case RatingRange.fourHalfPlus:
      return "4.5+";
    case RatingRange.fourPlus:
      return "4.0+";
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
    case Language.all:
      return "All";
  }
}

String genderToText(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "I am male";
    case Gender.female:
      return "I am female";
    case Gender.preferNotToSay:
      return "Prefer not to say";
  }
}

String ageToText(Age age) {
  switch (age) {
    case Age.from14To17:
      return "14 - 17";
    case Age.from18To24:
      return "18 - 24";
    case Age.from25To29:
      return "25 - 29";
    case Age.from30To34:
      return "30 - 34";
    case Age.from35To39:
      return "35 - 39";
    case Age.from40To44:
      return "40 - 44";
    case Age.from45To49:
      return "45 - 49";
    case Age.moreThan50:
      return ">= 50";
  }
}
