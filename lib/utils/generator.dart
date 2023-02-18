// ignore_for_file: unused_element

import 'dart:math';

import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/models/notification.dart' as no;
import 'package:bibliotheque/models/notifications_option.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:flutter/material.dart';

final generator = Generator();

class Generator {
  final _rand = Random();

  String _id() {
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

  static const _names = [
    'The house of hades (Heroes of olympics)',
    'My quiet Blacksmith, Life in Another world',
    'It starts with us: A novel',
    'Trapped in a dating Sim: The world',
    'His dark material: The golden company',
    'Batman: Arkham Unhinged vol. 1',
  ];

  static const _categories = [
    'Romance',
    'Thriller',
    'Inspirational',
    'Non-Fiction',
  ];

  static const _authors = [
    'J.K. Rowling',
    'Collen Hoover',
    'Victor franklin',
    'Phillip pullman',
  ];

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

  String _name() {
    return _names[_rand.nextInt(_names.length)];
  }

  String _category() {
    return _categories[_rand.nextInt(_categories.length)];
  }

  String _author() {
    return _authors[_rand.nextInt(_authors.length)];
  }

  String avatar() {
    return 'https://images.unsplash.com/photo-1553729784-e91953dec042?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGV'
        'yc29uJTIwcmVhZGluZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60';
  }

  Book book() => Book(
        id: _id(),
        name: _name(),
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

  Category category() => Category(
        id: _id(),
        name: _category(),
        imageUrl: _categoryCover,
      );

  BookDetails bookDetails() => BookDetails(
        id: _id(),
        name: _name(),
        coveUrl: _cover,
        price: count(1, 50) * 10,
        rate: _rate(),
        author: _author(),
        numPages: count(100, 1000),
        numBuyers: count(1, 100),
        numReviews: count(1, 2000),
        releaseDate: DateTime(2015, 11, 24),
        aboutBook: _loremIpsum,
        reviewsPercentage: [0.6, 0.12, 0.05, 0.03, 0.2],
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
        id: _id(),
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
        titleAr: 'titleAr',
        bodyAr: 'bodyAr',
        date: _dateTime(
          before: DateTime(2000),
          after: DateTime.now(),
        ),
      );

  Profile profile() => Profile(
        id: _id(),
        name: _name(),
        avatarUrl: avatar(),
        email: 'test@gmail.com',
        phoneNumber: '+249100640513',
      );

  NotificationsOptions notificationsOption() => NotificationsOptions(
        userId: _id(),
        newBookSeries: boolean(),
        newPriceDrop: boolean(),
        newPurchase: boolean(),
        newRecommendation: boolean(),
        newSurvey: boolean(),
        newTipOrService: boolean(),
        newUpdateFromAuthors: boolean(),
      );
}

extension RandomItemFromList on List {
  random(Random random) {
    return this[random.nextInt(length)];
  }
}
