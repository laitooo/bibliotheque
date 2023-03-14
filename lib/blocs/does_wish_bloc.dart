import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/wish_list_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum DoesWishStatus {
  loading,
  success,
  error,
}

class DoesWishState {
  final DoesWishStatus status;
  final bool? doesWish;
  final WishListError? error;

  DoesWishState(this.status, {this.doesWish, this.error});
}

class CheckWishStatus extends BlocEvent<DoesWishState, DoesWishBloc> {
  final String bookId;

  CheckWishStatus(this.bookId);
  @override
  Stream<DoesWishState> toState(
      DoesWishState current, DoesWishBloc bloc) async* {
    yield DoesWishState(
      DoesWishStatus.loading,
      doesWish: current.doesWish,
    );

    final res = await bloc._repo.isInWishList(bookId);

    yield res.incase(
      value: (value) {
        return DoesWishState(
          DoesWishStatus.success,
          doesWish: value,
        );
      },
      error: (error) {
        return DoesWishState(
          DoesWishStatus.error,
          error: error,
        );
      },
    );
  }
}

class AddToWishList extends BlocEvent<DoesWishState, DoesWishBloc> {
  final Book book;

  AddToWishList(this.book);
  @override
  Stream<DoesWishState> toState(
      DoesWishState current, DoesWishBloc bloc) async* {
    yield DoesWishState(
      DoesWishStatus.loading,
      doesWish: current.doesWish,
    );

    final res = await bloc._repo.addToWishList(book);

    yield res.incase(
      value: (value) {
        return DoesWishState(
          DoesWishStatus.success,
          doesWish: true,
        );
      },
      error: (error) {
        return DoesWishState(
          DoesWishStatus.error,
          error: error,
          doesWish: current.doesWish,
        );
      },
    );
  }
}

class RemoveFromWishList extends BlocEvent<DoesWishState, DoesWishBloc> {
  final String bookId;

  RemoveFromWishList(this.bookId);
  @override
  Stream<DoesWishState> toState(
      DoesWishState current, DoesWishBloc bloc) async* {
    yield DoesWishState(
      DoesWishStatus.loading,
      doesWish: current.doesWish,
    );

    final res = await bloc._repo.removeFromWishList(bookId);

    yield res.incase(
      value: (value) {
        return DoesWishState(
          DoesWishStatus.success,
          doesWish: false,
        );
      },
      error: (error) {
        return DoesWishState(
          DoesWishStatus.error,
          error: error,
          doesWish: current.doesWish,
        );
      },
    );
  }
}

class DoesWishBloc extends BaseBloc<DoesWishState> {
  final _repo = serviceLocator.get<WishListRepository>();

  DoesWishBloc() : super(DoesWishState(DoesWishStatus.loading));
}
