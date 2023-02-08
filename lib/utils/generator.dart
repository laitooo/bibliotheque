import 'dart:math';

import 'package:bibliotheque/models/book.dart';
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

  double rate() {
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

  final String _cover =
      "https://static.wikia.nocookie.net/iceandfire/images/b/b6/Game_of_thrones.jpeg/revision/latest?cb=20130302001049";

  String name() {
    return _names[_rand.nextInt(_names.length)];
  }

  String category() {
    return _categories[_rand.nextInt(_categories.length)];
  }

  Book book() => Book(
        id: id(),
        name: name(),
        coveUrl: _cover,
        price: count(1, 50) * 10,
        rate: rate(),
        categoriesIds: List.generate(
          count(1, 5),
          (index) => category(),
        ),
      );
}

extension RandomItemFromList on List {
  random(Random random) {
    return this[random.nextInt(length)];
  }
}
