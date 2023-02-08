import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.g.dart';
part 'book.freezed.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String name,
    required String coveUrl,
    required double price,
    required double rate,
    required List<String> categoriesIds,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
