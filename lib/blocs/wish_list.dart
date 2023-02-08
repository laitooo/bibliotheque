import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/wish_list.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum WishListStatus {
  loading,
  error,
  success,
}

class WishListState {
  final WishListStatus status;
  final List<Book>? books;
  final WishListError? error;

  WishListState(this.status, {this.books, this.error});
}

class LoadWishList extends BlocEvent<WishListState, WishListBloc> {
  @override
  Stream<WishListState> toState(
      WishListState current, WishListBloc bloc) async* {
    final res = await bloc._repo.getWishList();

    yield res.incase(
      value: (value) {
        return WishListState(
          WishListStatus.success,
          books: value,
        );
      },
      error: (error) {
        return WishListState(
          WishListStatus.error,
          error: error,
        );
      },
    );
  }
}

class WishListBloc extends BaseBloc<WishListState> {
  final _repo = serviceLocator.get<WishListRepository>();

  WishListBloc() : super(WishListState(WishListStatus.loading));
}
