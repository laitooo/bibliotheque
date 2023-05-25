import 'package:bibliotheque/blocs/books_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/home/home_tab.dart';
import 'package:bibliotheque/ui/screens/settings/account_settings_screen.dart';
import 'package:bibliotheque/ui/screens/wishlist/wish_list_screen.dart';
import 'package:bibliotheque/ui/widgets/books_list_page.dart';
import 'package:flutter/material.dart';

final globalHomeScreenKey = GlobalKey<HomeScreenState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HomeScreen(key: globalHomeScreenKey);
  }
}

class _HomeScreen extends StatefulWidget {
  final _pages = [
    const HomeTab(),
    BooksListPage(
      title: t.home.topPopular,
      booksSource: BooksSource.popular,
      canGoBack: false,
    ),
    const WishListScreen(),
    const AccountSettingsScreen(),
  ];
  _HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<_HomeScreen> {
  int selectedTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedTap,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _getBottomTabBarItem(
            title: t.home.home,
            iconPath: 'home',
            index: 0,
          ),
          _getBottomTabBarItem(
            title: t.home.discover,
            iconPath: 'discover',
            index: 1,
          ),
          _getBottomTabBarItem(
            title: t.home.wishlist,
            iconPath: 'wishlist',
            index: 2,
          ),
          _getBottomTabBarItem(
            title: t.home.account,
            iconPath: 'profile',
            index: 3,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedTap = index;
          });
        },
      ),
      body: widget._pages[selectedTap],
    );
  }

  _getBottomTabBarItem(
      {required String title, required String iconPath, required int index}) {
    return BottomNavigationBarItem(
      backgroundColor: context.theme.backgroundColor,
      label: title,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Svg(
          selectedTap == index
              ? "${iconPath}_active.svg"
              : "${iconPath}_inactive.svg",
          size: 24,
          color: selectedTap == index
              ? context.theme.activeColor
              : context.theme.inActiveColor,
        ),
      ),
    );
  }

  void gotoPopular() {
    setState(() {
      selectedTap = 1;
    });
  }

  void gotoWishList() {
    setState(() {
      selectedTap = 2;
    });
  }
}
