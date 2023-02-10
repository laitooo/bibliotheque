import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/books.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/result.dart';

enum BooksStatus {
  loading,
  error,
  success,
}

enum BooksSource {
  category,
  popular,
  recommended,
  search,
  // latest
}

class BooksState {
  final BooksStatus status;
  final List<Book>? books;
  final BooksError? error;

  BooksState(this.status, {this.books, this.error});
}

class LoadBooks extends BlocEvent<BooksState, BooksBloc> {
  final BooksSource booksSource;

  LoadBooks(this.booksSource);
  @override
  Stream<BooksState> toState(BooksState current, BooksBloc bloc) async* {
    final res = await getBooks(booksSource, bloc);

    yield res.incase(
      value: (value) {
        return BooksState(
          BooksStatus.success,
          books: value,
        );
      },
      error: (error) {
        return BooksState(
          BooksStatus.error,
          // TODO: handle this correctly
          error: BooksError.networkError,
        );
      },
    );
  }

  Future<Result<List<Book>, dynamic>> getBooks(
      BooksSource source, BooksBloc bloc) async {
    switch (source) {
      case BooksSource.category:
        return bloc._repo.getCategoryBooks();
      case BooksSource.recommended:
        return bloc._repo.getRecommendedBooks();
      case BooksSource.search:
        return bloc._repo.searchBooks();
      case BooksSource.popular:
        return bloc._repo.getPopularBooks();
    }
  }
}

class BooksBloc extends BaseBloc<BooksState> {
  final _repo = serviceLocator.get<BooksRepository>();

  BooksBloc() : super(BooksState(BooksStatus.loading));
}
