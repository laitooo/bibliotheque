import 'package:bibliotheque/models/question.dart';
import 'package:bibliotheque/repos/faqs_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum FAQsStatus {
  loading,
  error,
  success,
}

class FAQsState {
  final FAQsStatus status;
  final List<Question>? faqs;
  final FAQError? error;

  FAQsState(this.status, {this.faqs, this.error});
}

class LoadFAQs extends BlocEvent<FAQsState, FAQsBloc> {
  final QuestionType type;

  LoadFAQs(this.type);
  @override
  Stream<FAQsState> toState(FAQsState current, FAQsBloc bloc) async* {
    yield FAQsState(FAQsStatus.loading);

    final res = await bloc._repo.loadFAQs(type);

    yield res.incase(
      value: (value) {
        return FAQsState(
          FAQsStatus.success,
          faqs: value,
        );
      },
      error: (error) {
        return FAQsState(
          FAQsStatus.error,
          error: error,
        );
      },
    );
  }
}

class FAQsBloc extends BaseBloc<FAQsState> {
  final _repo = serviceLocator<FAQsRepository>();
  FAQsBloc() : super(FAQsState(FAQsStatus.loading));
}
