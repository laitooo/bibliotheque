import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/repos/search_repo.dart';
import 'package:bibliotheque/utils/error_enums.dart';

String questionToText(QuestionType type) {
  switch (type) {
    case QuestionType.general:
      return t.enums.question.general;
    case QuestionType.account:
      return t.enums.question.account;
    case QuestionType.service:
      return t.enums.question.service;
    case QuestionType.book:
      return t.enums.question.books;
    case QuestionType.payment:
      return t.enums.question.payment;
    case QuestionType.others:
      return t.enums.question.others;
  }
}

String ageRangeToText(AgeRange ageRange) {
  switch (ageRange) {
    case AgeRange.fiveUp:
      return t.enums.age.fiveUp;
    case AgeRange.eightUp:
      return t.enums.age.eightUp;
    case AgeRange.thirteenUp:
      return t.enums.age.thirteenUp;
    case AgeRange.eighteenUp:
      return t.enums.age.eighteenUp;
    case AgeRange.twentyUp:
      return t.enums.age.twentyUp;
    case AgeRange.all:
      return t.enums.age.all;
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
      return t.enums.sorting.trending;
    case SortingMethod.newReleases:
      return t.enums.sorting.newRelease;
    case SortingMethod.highestRating:
      return t.enums.sorting.highRate;
    case SortingMethod.lowestRating:
      return t.enums.sorting.lowRate;
    case SortingMethod.highestPrice:
      return t.enums.sorting.highPrice;
    case SortingMethod.lowestPrice:
      return t.enums.sorting.lowPrice;
  }
}

String ratingRangeToText(RatingRange ratingRange) {
  switch (ratingRange) {
    case RatingRange.all:
      return t.enums.all;
    case RatingRange.fourHalfPlus:
      return "4.5+";
    case RatingRange.fourPlus:
      return "4.0+";
  }
}

String languageToText(Language language) {
  switch (language) {
    case Language.arabic:
      return t.enums.language.arabic;
    case Language.english:
      return t.enums.language.english;
    case Language.french:
      return t.enums.language.french;
    case Language.spanish:
      return t.enums.language.spanish;
    case Language.all:
      return t.enums.language.all;
  }
}

String genderToText(Gender gender) {
  switch (gender) {
    case Gender.male:
      return t.enums.gender.male;
    case Gender.female:
      return t.enums.gender.female;
    case Gender.preferNotToSay:
      return t.enums.gender.preferNotSay;
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

String reviewsErrorToText(ReviewsError error) {
  switch (error) {
    case ReviewsError.fetchingAvatar:
    case ReviewsError.loadingError:
    case ReviewsError.submittingError:
      return t.errors.networkErrorTryAgain;
    case ReviewsError.invalidRate:
      return t.errors.invalidRate;
  }
}
