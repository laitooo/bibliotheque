import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

// Example Usage: The infamous flutter counter example
//
// class CounterBloc extends BaseBloc<CounterState> {
//   CounterBloc() : super(CounterState(0));
// } // or just use BaseBloc<CounterState>(CounterState(0))
//   // or let the event.toState handle null current state.
//
// class CounterState extends BlocState {
//   int count;
//
//   CounterState([this.count = 0]) : super([count]);
//
//   @override
//   toString() => "CounterState(count: $count)";
// }
//
// class CounterIncrementEvent extends BlocEvent<CounterState, CounterBloc> {
//   final int by;
//
//   CounterIncrementEvent({this.by = 1}) : super([by])
//
//   @override
//   toState(current, bloc) {
//     yield CounterState(current.count + by);
//   }
//
//   @override
//   toString() => "CounterIncrementEvent(by: $by)";
// }

typedef TransitionFunction<Event, State> = Stream<Transition<Event, State>>
    Function(Event);

abstract class BlocEvent<S, B extends BaseBloc> {
  const BlocEvent();

  Stream<S> toState(S current, B bloc);
}

class BaseBloc<S> extends Bloc<BlocEvent<S, BaseBloc>, S> {
  BaseBloc(S initialState) : super(initialState);

  @override
  Stream<S> mapEventToState(BlocEvent<S, BaseBloc> event) {
    return event.toState(state, this);
  }

  @override
  Stream<Transition<BlocEvent<S, BaseBloc>, S>> transformEvents(
      Stream<BlocEvent<S, BaseBloc>> events,
      TransitionFunction<BlocEvent<S, BaseBloc>, S> transitionFn) {
    return events.asyncExpand(transitionFn);
  }

  @override
  void onEvent(event) {
    super.onEvent(event);
    debugPrint("\n");
    debugPrint("======");
    debugPrint("Event dispatched for bloc: $this");
    debugPrint("\tevent: $event");
    debugPrint("\t currentState: $state");
    debugPrint("======");
    debugPrint("\n");
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    debugPrint("\n");
    debugPrint("======");
    debugPrint("Event successfully dispatched for bloc: $this");
    debugPrint("\tevent: ${transition.event}");
    debugPrint("\tcurrentState: ${transition.currentState}");
    debugPrint("\tnextState: ${transition.nextState}");
    debugPrint("======");
    debugPrint("\n");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint("\n");
    debugPrint("======");
    debugPrint("Error occured while dispatching event for bloc: $this");
    debugPrint("\terror: $error");
    debugPrint("\tstacktrace: $stackTrace");
    debugPrint("======");
    debugPrint("\n");
  }

  @override
  String toString() => runtimeType.toString();
}
