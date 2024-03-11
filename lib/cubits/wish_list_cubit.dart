import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/repos/wish_list_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WishListState {
  const WishListState();
}

class WishListLoading extends WishListState {
  WishListLoading() : super();
}

class WishListLoaded extends WishListState {
  final List<Book> books;
  WishListLoaded(this.books) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WishListLoaded &&
        other.books == books &&
        other.books.length == books.length;
  }

  @override
  int get hashCode => books.hashCode;
}

class WishListError extends WishListState {
  final String message;
  WishListError(this.message) : super();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WishListError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class WishListCubit extends Cubit<WishListState> {
  final _repo = serviceLocator.get<WishListRepository>();

  WishListCubit() : super(WishListLoading());

  void loadWishList(bool shouldLoadAll) async {
    emit(WishListLoading());
    final res = await _repo.getWishList(shouldLoadAll);
    if (res.isValue) {
      emit(WishListLoaded(res.asValue));
    } else {
      emit(WishListError('Loading error'));
    }
  }

  void removeFromWishList(String bookId) async {
    print('removing from wish list book id: $bookId');
    final res = await _repo.removeFromWishList(bookId);
    if (res.isValue) {
      print('removed, len before ${(state as WishListLoaded).books.length}');
      emit(WishListLoaded(List.of((state as WishListLoaded).books)..removeWhere((book) => book.id == bookId)));
      print('removed, len after ${(state as WishListLoaded).books.length}');
    } else {
      print('error');
      emit(WishListError('Removing error'));
    }
  }
}
