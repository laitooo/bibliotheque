import 'dart:math';

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

  double rate() {
    return _rand.nextInt(50) / 10;
  }

  static const String picture =
      'https://images.unsplash.com/photo-1520719627573-5e2c1a6610f0?h=500&w=500&fit=crop';

  static const String servicePicture =
      'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y2xvdGglMjB3YXNofGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60';

  static const orderCategories = [
    'General cleaning',
    'Clothes washing',
    'In house shaving',
    'Backyard and removal works',
    'Devices fixing',
    'Car servant',
  ];

  static const _names = [
    'Alziber Mohammed',
    'Akram Izzeldin',
    'Mohammed Hashim',
    'Saif Elislam',
  ];

  static const _donationCentersNames = [
    'مجمع النور',
    'مسجد الشهيد',
    'مسجد المقرن',
    'مسجد الخليفة',
    'مسجد الشيخ قريب الله',
    'مسجد النيلين',
    'الجامع الكبير',
    'مقبرة الشيخ السماني',
    'مبنى سكني قيد الانشاء'
  ];

  String name() {
    return _names[_rand.nextInt(_names.length)];
  }

  String orderCategory() {
    return orderCategories[_rand.nextInt(orderCategories.length)];
  }

  String donationCenterName() {
    return _donationCentersNames[_rand.nextInt(_donationCentersNames.length)];
  }

  bool boolean() {
    return _rand.nextBool();
  }

  T oneOf<T>(List<T> choices) {
    return choices[_rand.nextInt(choices.length)];
  }

  List<T> sample<T>(List<T> population, {int? size}) {
    size ??= count(population.length);
    size = size > population.length ? population.length : size;
    return List.generate(
        size, (index) => population[_rand.nextInt(population.length)]);
  }

  static const _countryCodes = [
    '+249',
  ];
  String phoneNumber() {
    return _countryCodes.random(_rand) + '123456789';
  }

  String text(int count, [int? max]) {
    count = max == null ? count : _rand.nextInt(max - count) + count;
    return List.generate(count, (i) => _words.random(_rand)).join(' ');
  }

  /// if before and after aren't specified, the returned dateTime is between
  /// now and the next year
  /// if after isn't specified, the returned dateTime is between `before`
  /// and the year before it.
  /// if before isn't specified, the returned dateTime is between `after` and the
  /// year after it.
  DateTime dateTime({DateTime? after, DateTime? before}) {
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

  DateTime time({DateTime? after, DateTime? before}) {
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

  TimeOfDay timeOfDay({TimeOfDay? after}) {
    DateTime? afterTime;
    if (after != null) {
      afterTime = DateTime(2000, 1, 1, after.hour, after.minute, 0);
    }
    final time = generator.time(after: afterTime);
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }
}

extension RandomItemFromList on List {
  random(Random random) {
    return this[random.nextInt(length)];
  }
}

const _words = [
  'fall',
  'former',
  'happen',
  'agent',
  'response',
  'result',
  'my',
  'gas',
  'human',
  'cultural',
  'war',
  'method',
  'Democrat',
  'you',
  'notice',
  'lay',
  'reason',
  'western',
  'fill',
  'key',
  'force',
  'event',
  'leave',
  'turn',
  'find',
  'prove',
  'less',
  'culture',
  'son',
  'sound',
  'happy',
  'fire',
  'chair',
  'race',
  'eight',
  'degree',
  'forget',
  'series',
  'interesting',
  'significant',
  'surface',
  'main',
  'yeah',
  'cancer',
  'private',
  'every',
  'father',
  'woman',
  'chance',
  'small'
];
