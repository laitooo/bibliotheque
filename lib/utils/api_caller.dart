import 'dart:async';

import 'package:bibliotheque/utils/result.dart';
import 'package:flutter/foundation.dart';

typedef ErrorReporterCallback = void Function(dynamic exception, StackTrace st);

/// usage:
///
/// in Controller
/// ```
/// final caller = serviceLocator<ApiCaller>();
/// final auth = serviceLocator<AuthRepository>();
/// ```
/// then use it to make an api call
/// ```
/// final result = await caller.call(() => auth.signIn());
/// ```
/// or alternatively if the network call returns a stream
/// ```
/// final stream = await caller.stream(() => auth.userStatus());
/// ```
/// which would transform all errors into data events of type Result.error
///
/// this is used so that exceptions don't leak to application layer
/// and to have a indirection level between repositories and Controllers for
/// logging and other operations.
class ApiCaller {
  final List<ErrorReporterCallback> _errorReporters = [];

  ApiCaller();

  Future<Result<T, E?>> call<T, E>(Future<T> Function() delegate) async {
    T response;
    try {
      response = await delegate();
    } catch (e, stacktrace) {
      if (e is E && dynamic is! E) {
        _logError(e, stacktrace);
        return Result.error(e as E);
      } else {
        _logError(e, stacktrace, isExpected: false);
        return Result.error(null);
      }
    }

    return Result.value(response);
  }

  Stream<Result<T, E?>> stream<T, E>(Stream<T> Function() delegate) {
    try {
      return delegate().transform(
        StreamTransformer.fromHandlers(
          handleData: (data, sink) {
            sink.add(Result.value(data));
          },
          handleError: (e, st, sink) {
            if (e is E && dynamic is! E) {
              _logError(e, st);
              sink.add(Result.error(e as E));
            } else {
              _logError(e, st, isExpected: false);
              sink.add(Result.error(null));
            }
          },
        ),
      );
    } catch (e, st) {
      _logError(e, st);
      return Stream.error(Result.error(null));
    }
  }

  void _logError<E>(E e, StackTrace stacktrace, {bool isExpected = true}) {
    for (final reporter in _errorReporters) {
      reporter(e, stacktrace);
    }
    debugPrint('');
    debugPrint(
        '=============== ${isExpected ? "" : "UNCAUGHT"} DATA ERROR ===============');
    debugPrint(e.toString());
    debugPrint(stacktrace.toString());
    debugPrint(
        '=============== ${isExpected ? "" : "UNCAUGHT"} DATA ERROR ===============');
    debugPrint('');
  }

  addErrorReporter(ErrorReporterCallback reporter) {
    _errorReporters.add(reporter);
  }
}
