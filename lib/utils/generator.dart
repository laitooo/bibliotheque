// ignore_for_file: unused_element

import 'dart:math';

import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/models/notification.dart' as no;
import 'package:bibliotheque/models/notifications_option.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/models/user.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';

final generator = Generator();

class Generator {
  final _rand = Random();

  String id() {
    return List.generate(
        10, (i) => String.fromCharCode(_rand.nextInt(127 - 33) + 33)).join();
  }

  int count(int a, [int? b]) {
    final max = b ?? a;
    final min = b == null ? 0 : a;
    return _rand.nextInt(max - min) + min;
  }

  bool boolean() {
    return _rand.nextBool();
  }

  T _oneOf<T>(List<T> choices) {
    return choices[_rand.nextInt(choices.length)];
  }

  List<T> _sample<T>(List<T> population, {int? size}) {
    size ??= count(population.length);
    size = size > population.length ? population.length : size;
    return List.generate(
        size, (index) => population[_rand.nextInt(population.length)]);
  }

  static const _countryCodes = [
    '+249',
  ];

  String _phoneNumber() {
    return _countryCodes.random(_rand) + '123456789';
  }

  /// if before and after aren't specified, the returned dateTime is between
  /// now and the next year
  /// if after isn't specified, the returned dateTime is between `before`
  /// and the year before it.
  /// if before isn't specified, the returned dateTime is between `after` and the
  /// year after it.
  DateTime _dateTime({DateTime? after, DateTime? before}) {
    after ??= before != null
        ? before.subtract(const Duration(days: 365))
        : DateTime.now();
    before ??= after.add(const Duration(days: 365));
    final afterMilliseconds = after.millisecondsSinceEpoch;
    final beforeMilliseconds = before.millisecondsSinceEpoch;
    final millisecondsRange = beforeMilliseconds - afterMilliseconds;
    return DateTime.fromMillisecondsSinceEpoch(
        // clips milliseconds range to the max valid value for `nextInt`
        _rand.nextInt(millisecondsRange & ((1 << 32) - 1)) + afterMilliseconds);
  }

  DateTime _time({DateTime? after, DateTime? before}) {
    // // we don't use the year, month, and day fields, but they are required
    // defaults to 00:00 begining of day
    after = DateTime(
        2000, 1, 1, after?.hour ?? 0, after?.minute ?? 0, after?.second ?? 0);
    // defaults to 23:59 end of day
    before = DateTime(2000, 1, 1, before?.hour ?? 23, before?.minute ?? 59,
        before?.second ?? 59);
    final afterMilliseconds = after.millisecondsSinceEpoch;
    final beforeMilliseconds = before.millisecondsSinceEpoch;
    final millisecondsRange = beforeMilliseconds - afterMilliseconds;
    return DateTime.fromMillisecondsSinceEpoch(
        _rand.nextInt(millisecondsRange & ((1 << 32) - 1)) + afterMilliseconds);
  }

  TimeOfDay _timeOfDay({TimeOfDay? after}) {
    DateTime? afterTime;
    if (after != null) {
      afterTime = DateTime(2000, 1, 1, after.hour, after.minute, 0);
    }
    final time = generator._time(after: afterTime);
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  double _rate() {
    return _rand.nextInt(50) / 10;
  }

  static const _users = [
    'Charlotte Hanlin',
    'Alfonzo Schuessler',
    'Maryland Winkles',
    'Alzobair Mohammed',
    'Howard Rivera',
  ];

  static const _books = [
    'Bullshit jobs',
    'The age of Vikings',
    'A brief history of humankind Sapiens',
    'Men are from Mars Women are from Venus',
    'جمهورية أفلاطون',
    'Talking to my daughter about the Economy',
    ' فن الحرب',
  ];

  static const _categories = [
    'Romance',
    'Thriller',
    'Inspirational',
    'Non-Fiction',
  ];

  static const _categoriesAr = [
    'رومانسي',
    'رعب',
    'ملهم',
    'واقعي',
  ];

  static const _authors = [
    'J.K. Rowling',
    'Collen Hoover',
    'Victor franklin',
    'Phillip pullman',
  ];

  static const _publishers = [
    'Pottermore Publishing',
    'Harper Collins',
    'Macmillan',
    'Simon and Schuster',
  ];

  static const _searchHistory = [
    "I'm glad my mom died",
    "Don't tell mama",
    "They let dad return",
    "Harry Potter and the half blood prince",
    "Taken by the dragon king",
  ];

  static const _countries = [
    'Sudan',
    'Japan',
    'Canada',
    'United kingdom',
    'United arab emirates',
  ];

  final String _email = "alziber50@gmail.com";

  final String _cover =
      "https://static.wikia.nocookie.net/iceandfire/images/b/b6/Game_of_thrones.jpeg/revision/latest?cb=20130302001049";

  final String _categoryCover =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7geJofAX7-2aS4LjFnuR2xibj-Hxcbm3WKg&usqp=CAU";

  final String _loremIpsum =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
      " Pellentesque dictum consectetur tincidunt. Nullam ultrices imperdiet posuere."
      " Maecenas ipsum dui, tincidunt nec lorem sed, blandit congue lacus. Cras fermentum ut nunc at mattis."
      " Etiam sed risus enim. Cras vel est in tellus feugiat fringilla. Praesent consequat lectus quis elementum commodo."
      " Integer quis suscipit enim. Donec ipsum purus, posuere at sem vel, finibus placerat erat."
      " Mauris consequat ipsum eros, in mattis nibh consectetur eu. Praesent varius faucibus dolor non malesuada."
      " Cras vel tellus in nisl sagittis lacinia. Suspendisse eget porta enim. Nullam feugiat fringilla gravida."
      " Suspendisse a neque malesuada, mollis tortor vitae.";

  String _userName() {
    return _users[_rand.nextInt(_users.length)];
  }

  String _bookName() {
    return _books[_rand.nextInt(_books.length)];
  }

  String _category() {
    return !prefs.isArabic()
        ? _categories[_rand.nextInt(_categories.length)]
        : _categoriesAr[_rand.nextInt(_categoriesAr.length)];
  }

  String _author() {
    return _authors[_rand.nextInt(_authors.length)];
  }

  String _country() {
    return _countries[_rand.nextInt(_countries.length)];
  }

  String avatar() {
    return "assets/mock/avatar/" + _oneOf(["male", "female"]) + ".png";
  }

  Book book() => Book(
        id: id(),
        name: _bookName(),
        coveUrl: _cover,
        price: count(1, 50) * 10,
        rate: _rate(),
        categoriesIds: List.generate(
          count(1, 5),
          (index) => _category(),
        ),
        categoriesNames: List.generate(
          count(1, 5),
          (index) => _category(),
        ),
      );

  Category category({String? index}) => Category(
        id: index ?? id(),
        nameAr: _categoriesAr[_rand.nextInt(_categoriesAr.length)],
        nameEn: _categories[_rand.nextInt(_categories.length)],
        imageUrl: _categoryCover,
      );

  String searchHistory() {
    return _searchHistory[_rand.nextInt(_searchHistory.length)];
  }

  BookDetails bookDetails() => BookDetails(
        id: id(),
        name: _bookName(),
        coveUrl: _cover,
        price: count(1, 50) * 10,
        rate: _rate(),
        authorId: id(),
        authorName: _author(),
        publisherId: id(),
        publisherName: _oneOf(_publishers),
        numPages: count(100, 1000),
        numBuyers: count(1, 100),
        numReviews: count(1, 2000),
        publishDate: DateTime(2015, 11, 24),
        aboutBook: _loremIpsum,
        reviewsPercentage: [0.6, 0.12, 0.05, 0.03, 0.2],
        isbn: "9781781102435",
        age: AgeRange.twentyUp,
        language: Language.english,
        categoriesIds: List.generate(
          count(1, 5),
          (index) => _category(),
        ),
        categoriesNames: List.generate(
          count(1, 5),
          (index) => _category(),
        ),
      );

  no.Notification notification() => no.Notification(
        id: id(),
        user: 'user',
        event: no.NotificationEvent(
          context: {},
          type: _oneOf(no.NotificationType.values),
        ),
        target: no.NotificationTarget.donor,
        role: no.UserRole.donor,
        title: 'Multiple cards features!',
        body:
            'Update the app now to get access to the latest features for better experience using the app.',
        titleAr: 'ميزة البطاقات المتعددة',
        bodyAr:
            'قم بتحديث التطبيق للحصول على آخر الميزات لتجربة أداء أفضل في استخدام التطبيق',
        date: _dateTime(
          before: DateTime(2000),
          after: DateTime.now(),
        ),
      );

  Profile profile() => Profile(
        id: id(),
        email: _email,
        username: _userName(),
        fullName: _userName(),
        avatarUrl: "",
        phoneNumber: '+249100640513',
        gender: _oneOf(Gender.values),
        age: _oneOf(Age.values),
        country: _country(),
        favouriteCategories: List.generate(
          count(1, 5),
          (index) => _category(),
        ),
        birthDate: _dateTime(
          before: DateTime(1900),
          after: DateTime(2020),
        ),
      );

  NotificationsOptions notificationsOption() => NotificationsOptions(
        userId: id(),
        newBookSeries: boolean(),
        newPriceDrop: boolean(),
        newPurchase: boolean(),
        newRecommendation: boolean(),
        newSurvey: boolean(),
        newTipOrService: boolean(),
        newUpdateFromAuthors: boolean(),
      );

  Question faq() => Question(
        id: id(),
        questionAr: "ما هدف تطبيق المكتبة",
        answerAr: "هدف التطبيق هو تسهيل عملية شراء وتوصيل الكتب الى القراء."
            "كما يتيح امكانية تصفح التكتب الموجودة ورؤية تقييمات القراء",
        questionEn: "What is Bibliotheque?",
        answerEn:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Congue tempor, a sit accumsan",
        type: _oneOf(QuestionType.values),
      );

  Review review({StarsNumber? starsNumber}) => Review(
        id: id(),
        userId: id(),
        userName: _userName(),
        userCover: "",
        hasLiked: boolean(),
        numStars: starsNumber ?? _oneOf(StarsNumber.values),
        numLikes: count(10, 1000),
        creationDate: _dateTime(
          before: DateTime(2000),
          after: DateTime.now(),
        ),
        content:
            "As a person who has a hard time picking up a book to read. I very"
            " much enjoy this book and definitely wouldn't mind reading it again.",
      );

  User user() => User(
        id: id(),
        email: _email,
        username: _userName(),
      );
}

extension RandomItemFromList on List {
  random(Random random) {
    return this[random.nextInt(length)];
  }
}
