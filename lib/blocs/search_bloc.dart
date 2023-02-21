import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/search_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum SearchStatus {
  idle,
  loading,
  error,
  success,
}

class SearchState {
  final SearchStatus status;
  final List<Book>? books;
  final SearchError? error;

  SearchState(this.status, {this.books, this.error});
}

class SearchBook extends BlocEvent<SearchState, SearchBloc> {
  final String query;

  SearchBook(this.query);

  @override
  Stream<SearchState> toState(SearchState current, SearchBloc bloc) async* {
    yield SearchState(SearchStatus.loading);

    if (query.isEmpty) {
      yield SearchState(
        SearchStatus.error,
        books: current.books,
        error: SearchError.invalidQuery,
      );
      return;
    }

    final res = await bloc._repo.search(query);

    yield res.incase(
      value: (value) {
        return SearchState(
          SearchStatus.success,
          books: value,
        );
      },
      error: (error) {
        return SearchState(
          SearchStatus.error,
          error: error,
        );
      },
    );
  }
}

class SearchBloc extends BaseBloc<SearchState> {
  final _repo = serviceLocator.get<SearchRepository>();

  SearchBloc() : super(SearchState(SearchStatus.idle));
}
