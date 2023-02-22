import 'package:bibliotheque/entities/filter_options.dart';
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
  final String query;
  final FilterOptions filterOptions;
  final SearchError? error;

  SearchState(
    this.status, {
    required this.query,
    required this.filterOptions,
    required this.books,
    this.error,
  });
}

class SearchBook extends BlocEvent<SearchState, SearchBloc> {
  final String? query;
  final FilterOptions? options;

  SearchBook({this.query, this.options});

  @override
  Stream<SearchState> toState(SearchState current, SearchBloc bloc) async* {
    yield SearchState(
      SearchStatus.loading,
      query: query ?? current.query,
      filterOptions: options ?? current.filterOptions,
      books: current.books,
    );

    final res = await bloc._repo.search(
      query ?? current.query,
      options ?? current.filterOptions,
    );

    yield res.incase(
      value: (value) {
        return SearchState(
          SearchStatus.success,
          query: query ?? current.query,
          filterOptions: options ?? current.filterOptions,
          books: value,
        );
      },
      error: (error) {
        return SearchState(
          SearchStatus.error,
          query: query ?? current.query,
          filterOptions: options ?? current.filterOptions,
          error: error,
          books: current.books,
        );
      },
    );
  }
}

class SearchBloc extends BaseBloc<SearchState> {
  final _repo = serviceLocator.get<SearchRepository>();

  SearchBloc()
      : super(
          SearchState(
            SearchStatus.idle,
            query: "",
            books: [],
            filterOptions: FilterOptions.emptyFilter(),
          ),
        );
}
