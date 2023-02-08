import 'package:bibliotheque/models/category.dart';
import 'package:bibliotheque/repos/categories.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum CategoriesStatus {
  loading,
  error,
  success,
}

class CategoriesState {
  final CategoriesStatus status;
  final List<Category>? categories;
  final CategoriesError? error;

  CategoriesState(this.status, {this.categories, this.error});
}

class LoadCategories extends BlocEvent<CategoriesState, CategoriesBloc> {
  @override
  Stream<CategoriesState> toState(
      CategoriesState current, CategoriesBloc bloc) async* {
    final res = await bloc._repo.getCategories();

    yield res.incase(
      value: (value) {
        return CategoriesState(
          CategoriesStatus.success,
          categories: value,
        );
      },
      error: (error) {
        return CategoriesState(
          CategoriesStatus.error,
          error: error,
        );
      },
    );
  }
}

class CategoriesBloc extends BaseBloc<CategoriesState> {
  final _repo = serviceLocator.get<CategoriesRepositories>();

  CategoriesBloc() : super(CategoriesState(CategoriesStatus.loading));
}
