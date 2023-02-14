import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlocGenericLoader<T extends BaseBloc<S>, S> extends StatefulWidget {
  final BlocEvent<S, BaseBloc>? event;
  final dynamic loadingState;
  final dynamic errorState;
  final dynamic successState;
  final Function onSuccess;
  final double loadingWidgetHeight;
  final Function? noStateBuilder;

  const BlocGenericLoader({
    Key? key,
    this.event,
    required this.loadingState,
    required this.errorState,
    required this.successState,
    required this.onSuccess,
    this.loadingWidgetHeight = 200,
    this.noStateBuilder,
  }) : super(key: key);

  @override
  State<BlocGenericLoader> createState() => BlocGenericLoaderState<T, S>();
}

class BlocGenericLoaderState<T extends BaseBloc<S>, S>
    extends State<BlocGenericLoader> {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<T>(context);
    if (widget.event != null) {
      var e = (widget.event) as BlocEvent<S, BaseBloc>;
      bloc.add(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, S>(
      listener: (BuildContext context, state) {},
      child: BlocBuilder<T, S>(
        builder: (BuildContext context, S state) {
          if (isLoading(state)) {
            return loadingWidget();
          } else if (isError(state)) {
            return errorWidget();
          } else if (isSuccess(state)) {
            return successWidget(state);
          }
          if (widget.noStateBuilder != null) {
            return widget.noStateBuilder!.call();
          }
          return Container();
        },
      ),
    );
  }

  // Helpers
  bool isLoading(S state) => state.runtimeType == widget.loadingState;

  bool isError(S state) => state.runtimeType == widget.errorState;

  bool isSuccess(S state) => state.runtimeType == widget.successState;

  void tryAgain() {
    if (widget.event != null) {
      var e = (widget.event) as BlocEvent<S, BaseBloc>;
      bloc.add(e);
    }
  }

  Widget loadingWidget() {
    return const Center(child: AppProgressIndicator());
  }

  Widget errorWidget() {
    return TryAgainWidget(
      onPressed: tryAgain,
    );
  }

  Widget successWidget(S state) {
    return widget.onSuccess(state);
  }
}

class TryAgainWidget extends StatelessWidget {
  final Function onPressed;

  const TryAgainWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).errors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/network_error.svg',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 90),
          Text(
            t.networkError,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 16),
          MainButton(
            title: t.tryAgain,
            onPressed: () {
              onPressed.call();
            },
          )
        ],
      ),
    );
  }
}
