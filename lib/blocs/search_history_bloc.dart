import 'package:bibliotheque/repos/search_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum SearchHistoryStatus {
  loading,
  error,
  success,
}

class SearchHistoryState {
  final SearchHistoryStatus status;
  final List<String>? list;
  final SearchHistoryError? error;

  SearchHistoryState(this.status, {this.list, this.error});
}

class LoadSearchHistory
    extends BlocEvent<SearchHistoryState, SearchHistoryBloc> {
  @override
  Stream<SearchHistoryState> toState(
      SearchHistoryState current, SearchHistoryBloc bloc) async* {
    final res = await bloc._repo.getSearchHistory();

    yield res.incase(
      value: (value) {
        return SearchHistoryState(
          SearchHistoryStatus.success,
          list: value,
        );
      },
      error: (error) {
        return SearchHistoryState(
          SearchHistoryStatus.error,
          error: error,
        );
      },
    );
  }
}

class ClearSearchHistory
    extends BlocEvent<SearchHistoryState, SearchHistoryBloc> {
  @override
  Stream<SearchHistoryState> toState(
      SearchHistoryState current, SearchHistoryBloc bloc) async* {
    final res = await bloc._repo.getSearchHistory();

    yield res.incase(
      value: (value) {
        return SearchHistoryState(
          SearchHistoryStatus.success,
          list: [],
        );
      },
      error: (error) {
        return SearchHistoryState(
          SearchHistoryStatus.error,
          error: error,
        );
      },
    );
  }
}

class RemovePreviousSearch
    extends BlocEvent<SearchHistoryState, SearchHistoryBloc> {
  final String query;

  RemovePreviousSearch(this.query);

  @override
  Stream<SearchHistoryState> toState(
      SearchHistoryState current, SearchHistoryBloc bloc) async* {
    final res = await bloc._repo.removePreviousSearchQuery(query);

    yield res.incase(
      value: (value) {
        return SearchHistoryState(
          SearchHistoryStatus.success,
          list: current.list!..removeWhere((element) => element == query),
        );
      },
      error: (error) {
        return SearchHistoryState(
          SearchHistoryStatus.error,
          error: error,
        );
      },
    );
  }
}

class AddPreviousSearch
    extends BlocEvent<SearchHistoryState, SearchHistoryBloc> {
  final String query;

  AddPreviousSearch(this.query);

  @override
  Stream<SearchHistoryState> toState(
      SearchHistoryState current, SearchHistoryBloc bloc) async* {
    final res = await bloc._repo.addPreviousSearchQuery(query);

    yield res.incase(
      value: (value) {
        return SearchHistoryState(
          SearchHistoryStatus.success,
          list: current.list!..add(query),
        );
      },
      error: (error) {
        return SearchHistoryState(
          SearchHistoryStatus.error,
          error: error,
        );
      },
    );
  }
}

class SearchHistoryBloc extends BaseBloc<SearchHistoryState> {
  final _repo = serviceLocator.get<SearchRepository>();

  SearchHistoryBloc() : super(SearchHistoryState(SearchHistoryStatus.loading));
}
