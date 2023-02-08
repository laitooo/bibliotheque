import 'dart:async';

import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bibliotheque/blocs/theme.dart';

class _ErrorButton extends StatelessWidget {
  const _ErrorButton({
    required this.onRetry,
    Key? key,
  }) : super(key: key);

  final void Function(BuildContext context) onRetry;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () => onRetry(context),
        child: Text(t.errors.networkError),
      ),
    );
  }
}

class PaginatedList<
    ListBloc extends Bloc<dynamic, ListState>,
    ListState,
    ListInitial extends ListState,
    ListLoading extends ListState,
    ListEnd extends ListState,
    ListError extends ListState> extends StatefulWidget {
  const PaginatedList({
    Key? key,
    required this.header,
    this.emptyListIndicator,
    this.errorIndicator,
    required this.onLoadMore,
    this.onRetry,
    required this.getItemsCount,
    required this.buildItemWidget,
    this.initialStateBuilder,
    this.noItemsWidgetBuilder,
    this.bouncingScrollView = false,
    this.alwaysScrollableScrollView = false,
  }) : super(key: key);

  factory PaginatedList.separated({
    Key? key,
    required Widget header,
    Widget? emptyListIndicator,
    Widget Function(BuildContext context, void Function(BuildContext) onRetry)?
        errorIndicator,
    required void Function(BuildContext context) onLoadMore,
    void Function(BuildContext context)? onRetry,
    required int Function(ListState state) getItemsCount,
    required Widget Function(ListState state, int index) buildItemWidget,
    required Widget Function(ListState state, int index) buildSeparatorWidget,
  }) =>
      PaginatedList(
        key: key,
        header: header,
        emptyListIndicator: emptyListIndicator,
        errorIndicator: errorIndicator,
        onLoadMore: onLoadMore,
        onRetry: onRetry,
        getItemsCount: (state) {
          final count = getItemsCount(state);
          return count != 0 ? count * 2 - 1 : 0;
        },
        buildItemWidget: (state, index) {
          return index % 2 == 0
              ? buildItemWidget(state, index ~/ 2)
              : buildSeparatorWidget(state, (index - 1) ~/ 2);
        },
      );

  final Widget header;
  final Widget? emptyListIndicator;
  final Widget Function(
    BuildContext context,
    void Function(BuildContext) onRetry,
  )? errorIndicator;
  final void Function(BuildContext context) onLoadMore;
  final void Function(BuildContext context)? onRetry;
  final int Function(ListState state) getItemsCount;
  final Widget Function(ListState state, int index) buildItemWidget;
  final Widget Function()? initialStateBuilder;
  final Widget Function()? noItemsWidgetBuilder;
  final bool bouncingScrollView;
  final bool alwaysScrollableScrollView;

  bool canLoadMoreByScrolling(ListState state) {
    return state is! ListLoading &&
        state is! ListEnd &&
        state is! ListError &&
        state is! ListInitial;
  }

  @override
  _PaginatedListState<ListBloc, ListState, ListInitial, ListLoading, ListEnd,
          ListError>
      createState() => _PaginatedListState<ListBloc, ListState, ListInitial,
          ListLoading, ListEnd, ListError>();
}

class _PaginatedListState<
        ListBloc extends Bloc<dynamic, ListState>,
        ListState,
        ListInitial extends ListState,
        ListLoading extends ListState,
        ListEnd extends ListState,
        ListError extends ListState>
    extends State<
        PaginatedList<ListBloc, ListState, ListInitial, ListLoading, ListEnd,
            ListError>> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (_shouldLoadMore()) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, state) {
        // controller's listener is called only when the scolling changes. This creates a problem if the loaded page
        // is smaller than screen size, since the listener will not be called and hence next page won't be loaded.
        // To solve this, we add a listener to the list bloc state that is the same as scoll controller's listener.
        if (_shouldLoadMore()) {
          _loadMore();
        }
      },
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          final length = widget.getItemsCount(state);

          if (state is ListInitial && widget.initialStateBuilder != null) {
            return widget.initialStateBuilder!.call();
          }
          if (state is ListEnd &&
              length == 0 &&
              widget.noItemsWidgetBuilder != null) {
            return widget.noItemsWidgetBuilder!.call();
          }

          return ListView.builder(
            physics: widget.alwaysScrollableScrollView
                ? const AlwaysScrollableScrollPhysics()
                : widget.bouncingScrollView
                    ? const BouncingScrollPhysics()
                    : null,
            controller: controller,
            itemCount: length + 2,
            itemBuilder: (context, i) {
              final isHeader = i == 0;
              final isProgressIndicator = i == length + 1;

              if (isHeader) {
                return widget.header;
              }

              if (isProgressIndicator) {
                if (state is ListEnd) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: widget.emptyListIndicator),
                  );
                } else if (state is ListError) {
                  return widget.errorIndicator?.call(
                        context,
                        widget.onRetry ?? widget.onLoadMore,
                      ) ??
                      _ErrorButton(
                        onRetry: widget.onRetry ?? widget.onLoadMore,
                      );
                } else {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: AppProgressIndicator(
                        color: context.theme.primaryColor,
                      ),
                    ),
                  );
                }
              }

              return widget.buildItemWidget(state, i - 1);
            },
          );
        },
      ),
    );
  }

  bool _shouldLoadMore() {
    if (controller.hasClients &&
        controller.position.extentAfter <
            controller.position.extentInside ~/ 8) {
      final state = BlocProvider.of<ListBloc>(context).state;
      if (widget.canLoadMoreByScrolling(state)) {
        return true;
      }
    }
    return false;
  }

  void _loadMore() {
    widget.onLoadMore(context);
  }
}

class PaginatedPageView<
    ListBloc extends Bloc<dynamic, ListState>,
    ListState,
    ListLoading extends ListState,
    ListEnd extends ListState,
    ListError extends ListState> extends StatefulWidget {
  const PaginatedPageView({
    Key? key,
    this.controller,
    this.onPageChanged,
    required this.onLoadMore,
    void Function(BuildContext)? onRetry,
    required this.getItemsCount,
    required this.buildItemWidget,
    required this.scrollDirection,
    this.viewportFraction,
  })  : onRetry = onRetry ?? onLoadMore,
        assert(
            controller == null && viewportFraction != null ||
                controller != null && viewportFraction == null,
            "one of controller or viewportFraction must not be null"),
        super(key: key);

  final PageController? controller;
  final void Function(int page, ListState state)? onPageChanged;
  final void Function(BuildContext context) onLoadMore;
  final void Function(BuildContext context) onRetry;
  final int Function(ListState state) getItemsCount;
  final Widget Function(ListState state, int index) buildItemWidget;
  final Axis scrollDirection;
  final double? viewportFraction;

  bool canLoadMoreByScrolling(ListState state) {
    return state is! ListLoading && state is! ListEnd && state is! ListError;
  }

  @override
  _PaginatedPageViewState<ListBloc, ListState, ListLoading, ListEnd, ListError>
      createState() => _PaginatedPageViewState<ListBloc, ListState, ListLoading,
          ListEnd, ListError>();
}

class _PaginatedPageViewState<
        ListBloc extends Bloc<dynamic, ListState>,
        ListState,
        ListLoading extends ListState,
        ListEnd extends ListState,
        ListError extends ListState>
    extends State<
        PaginatedPageView<ListBloc, ListState, ListLoading, ListEnd,
            ListError>> {
  late PageController controller;
  StreamSubscription<ListState>? _pageChangedSubscription;
  final Completer<ListState> _firstPageLoadedCompleter = Completer();

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        PageController(viewportFraction: widget.viewportFraction!);
    controller.addListener(_loadMoreIfApplicable);
    _firstPageLoadedCompleter.future.then((state) {
      widget.onPageChanged?.call(0, state);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    _pageChangedSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(old) {
    if (old.controller != widget.controller) {
      controller.removeListener(_loadMoreIfApplicable);
      if (old.controller == null) {
        controller.dispose();
      }
      controller = widget.controller ??
          PageController(viewportFraction: widget.viewportFraction!);
      controller.addListener(_loadMoreIfApplicable);
    }
    super.didUpdateWidget(old);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, state) {
        if (!_firstPageLoadedCompleter.isCompleted &&
            _isLoadedState(state) &&
            widget.getItemsCount(state) > 0) {
          _firstPageLoadedCompleter.complete(state);
        }
        // controller's listener is called only when the scolling changes. This creates a problem if the loaded page
        // is smaller than screen size, since the listener will not be called and hence next page won't be loaded.
        // To solve this, we add a listener to the list bloc state that is the same as scoll controller's listener.
        _loadMoreIfApplicable();
      },
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          final length = widget.getItemsCount(state);
          return PageView.builder(
            onPageChanged: (p) {
              _pageChangedSubscription?.cancel();

              if (widget.getItemsCount(state) > p) {
                widget.onPageChanged?.call(p, state);
              } else {
                _pageChangedSubscription = BlocProvider.of<ListBloc>(context)
                    .stream
                    .listen((newState) {
                  if (newState is ListEnd) {
                    _pageChangedSubscription?.cancel();
                  } else if (_isLoadedState(newState) &&
                      widget.getItemsCount(newState) > p) {
                    _pageChangedSubscription?.cancel();
                    widget.onPageChanged?.call(p, newState);
                  }
                });
              }
            },
            controller: controller,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: length + 1,
            itemBuilder: (context, i) {
              final isProgressIndicator = i == length;

              if (isProgressIndicator) {
                if (state is ListEnd) {
                  return Container();
                } else if (state is ListError) {
                  return _ErrorButton(
                    onRetry: widget.onRetry,
                  );
                } else {
                  return Center(
                      child: AppProgressIndicator(
                    color: context.theme.primaryColor,
                  ));
                }
              }

              return widget.buildItemWidget(state, i);
            },
          );
        },
      ),
    );
  }

  bool _shouldLoadMore() {
    if (controller.position.extentAfter <
        controller.position.extentInside ~/ 8) {
      final state = BlocProvider.of<ListBloc>(context).state;
      if (widget.canLoadMoreByScrolling(state)) {
        return true;
      }
    }
    return false;
  }

  void _loadMoreIfApplicable() {
    if (_shouldLoadMore()) {
      widget.onLoadMore(context);
    }
  }

  _isLoadedState(ListState state) =>
      state is! ListLoading && state is! ListEnd && state is! ListError;
}

class PaginatedGridView<
    ListBloc extends Bloc<dynamic, ListState>,
    ListState,
    ListLoading extends ListState,
    ListEnd extends ListState,
    ListError extends ListState> extends StatefulWidget {
  const PaginatedGridView({
    Key? key,
    required this.header,
    this.emptyText,
    required this.onLoadMore,
    void Function(BuildContext context)? onRetry,
    required this.getItemsCount,
    required this.buildItemWidget,
    this.childAspectRatio = 1.0,
    required this.maxCrossAxisExtent,
  })  : onRetry = onRetry ?? onLoadMore,
        super(key: key);

  factory PaginatedGridView.separated({
    Key? key,
    required Widget header,
    String? emptyText,
    required void Function(BuildContext context) onLoadMore,
    void Function(BuildContext context)? onRetry,
    required int Function(ListState state) getItemsCount,
    required Widget Function(ListState state, int index) buildItemWidget,
    required Widget Function(ListState state, int index) buildSeparatorWidget,
    double childAspectRatio = 1.0,
    required double maxCrossAxisExtent,
  }) =>
      PaginatedGridView(
        key: key,
        header: header,
        emptyText: emptyText,
        onLoadMore: onLoadMore,
        onRetry: onRetry ?? onLoadMore,
        childAspectRatio: childAspectRatio,
        maxCrossAxisExtent: maxCrossAxisExtent,
        getItemsCount: (state) {
          final count = getItemsCount(state);
          return count != 0 ? count * 2 - 1 : 0;
        },
        buildItemWidget: (state, index) {
          return index % 2 == 0
              ? buildItemWidget(state, index ~/ 2)
              : buildSeparatorWidget(state, (index - 1) ~/ 2);
        },
      );

  final Widget header;
  final String? emptyText;
  final void Function(BuildContext context) onLoadMore;
  final void Function(BuildContext context) onRetry;
  final int Function(ListState state) getItemsCount;
  final Widget Function(ListState state, int index) buildItemWidget;
  final double childAspectRatio;
  final double maxCrossAxisExtent;

  bool canLoadMoreByScrolling(ListState state) {
    return state is! ListLoading && state is! ListEnd && state is! ListError;
  }

  @override
  _PaginatedGridViewState<ListBloc, ListState, ListLoading, ListEnd, ListError>
      createState() => _PaginatedGridViewState<ListBloc, ListState, ListLoading,
          ListEnd, ListError>();
}

class _PaginatedGridViewState<
        ListBloc extends Bloc<dynamic, ListState>,
        ListState,
        ListLoading extends ListState,
        ListEnd extends ListState,
        ListError extends ListState>
    extends State<
        PaginatedGridView<ListBloc, ListState, ListLoading, ListEnd,
            ListError>> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (_shouldLoadMore()) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListBloc, ListState>(
      listener: (context, state) {
        // controller's listener is called only when the scolling changes. This creates a problem if the loaded page
        // is smaller than screen size, since the listener will not be called and hence next page won't be loaded.
        // To solve this, we add a listener to the list bloc state that is the same as scoll controller's listener.
        if (_shouldLoadMore()) {
          _loadMore();
        }
      },
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          const endText = 'end of list';
          final length = widget.getItemsCount(state);

          return SingleChildScrollView(
            controller: controller,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.header,
                Flexible(
                  child: GridView.extent(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: widget.childAspectRatio,
                    padding: const EdgeInsets.all(20),
                    maxCrossAxisExtent: widget.maxCrossAxisExtent,
                    children: [
                      for (var i = 0; i < length; i++)
                        widget.buildItemWidget(state, i)
                    ],
                  ),
                ),
                if (state is ListEnd)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                            length == 0 ? widget.emptyText ?? endText : " ")),
                  )
                else if (state is ListError)
                  _ErrorButton(
                    onRetry: widget.onRetry,
                  )
                else
                  Center(
                    child: AppProgressIndicator(
                      color: context.theme.primaryColor,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _shouldLoadMore() {
    if (controller.position.extentAfter <
        controller.position.extentInside ~/ 8) {
      final state = BlocProvider.of<ListBloc>(context).state;
      if (widget.canLoadMoreByScrolling(state)) {
        return true;
      }
    }
    return false;
  }

  void _loadMore() {
    widget.onLoadMore(context);
  }
}
