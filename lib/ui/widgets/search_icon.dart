import 'package:bibliotheque/blocs/search_bloc.dart';
import 'package:bibliotheque/blocs/search_history_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchIcon extends StatelessWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => SearchBloc(),
                ),
                BlocProvider(
                  create: (_) => SearchHistoryBloc()..add(LoadSearchHistory()),
                ),
              ],
              child: const SearchScreen(),
            ),
          ),
        );
      },
      icon: const Svg(
        "search.svg",
      ),
    );
  }
}
