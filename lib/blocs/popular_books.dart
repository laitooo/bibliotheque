import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/books.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum PopularBooksStatus {
  loading,
  error,
  success,
}

class PopularBooksState {
  final PopularBooksStatus status;
  final List<Book>? books;
  final PopularBooksError? error;

  PopularBooksState(this.status, {this.books, this.error});
}

class LoadPopularBooks extends BlocEvent<PopularBooksState, PopularBooksBloc> {
  @override
  Stream<PopularBooksState> toState(
      PopularBooksState current, PopularBooksBloc bloc) async* {
    final res = await bloc._repo.getPopularBooks();

    yield res.incase(
      value: (value) {
        return PopularBooksState(
          PopularBooksStatus.success,
          books: value,
        );
      },
      error: (error) {
        return PopularBooksState(
          PopularBooksStatus.error,
          error: error,
        );
      },
    );
  }
}

class PopularBooksBloc extends BaseBloc<PopularBooksState> {
  final _repo = serviceLocator.get<BooksRepository>();

  PopularBooksBloc() : super(PopularBooksState(PopularBooksStatus.loading));
}
