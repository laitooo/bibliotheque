import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/books.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum RecommendedBooksStatus {
  loading,
  error,
  success,
}

class RecommendedBooksState {
  final RecommendedBooksStatus status;
  final List<Book>? books;
  final RecommendedBooksError? error;

  RecommendedBooksState(this.status, {this.books, this.error});
}

class LoadRecommendedBooks
    extends BlocEvent<RecommendedBooksState, RecommendedBooksBloc> {
  @override
  Stream<RecommendedBooksState> toState(
      RecommendedBooksState current, RecommendedBooksBloc bloc) async* {
    final res = await bloc._repo.getRecommendedBooks();

    yield res.incase(
      value: (value) {
        return RecommendedBooksState(
          RecommendedBooksStatus.success,
          books: value,
        );
      },
      error: (error) {
        return RecommendedBooksState(
          RecommendedBooksStatus.error,
          error: error,
        );
      },
    );
  }
}

class RecommendedBooksBloc extends BaseBloc<RecommendedBooksState> {
  final _repo = serviceLocator.get<BooksRepository>();

  RecommendedBooksBloc()
      : super(RecommendedBooksState(RecommendedBooksStatus.loading));
}
