import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/repos/book_details_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum BookDetailsStatus {
  loading,
  error,
  success,
}

class BookDetailsState {
  final BookDetailsStatus status;
  final BookDetails? details;
  final BookDetailsError? error;

  BookDetailsState(this.status, {this.details, this.error});
}

class LoadBookDetails extends BlocEvent<BookDetailsState, BookDetailsBloc> {
  final String bookId;

  LoadBookDetails(this.bookId);
  @override
  Stream<BookDetailsState> toState(
      BookDetailsState current, BookDetailsBloc bloc) async* {
    yield BookDetailsState(BookDetailsStatus.loading);

    final res = await bloc._repo.getBookDetails(bookId);

    yield res.incase(
      value: (value) {
        return BookDetailsState(
          BookDetailsStatus.success,
          details: value,
        );
      },
      error: (error) {
        return BookDetailsState(
          BookDetailsStatus.error,
          error: BookDetailsError.networkError,
        );
      },
    );
  }
}

class BookDetailsBloc extends BaseBloc<BookDetailsState> {
  final _repo = serviceLocator.get<BookDetailsRepository>();

  BookDetailsBloc() : super(BookDetailsState(BookDetailsStatus.loading));
}
