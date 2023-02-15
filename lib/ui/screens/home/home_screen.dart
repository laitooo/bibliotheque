import 'package:bibliotheque/blocs/books_bloc.dart';
import 'package:bibliotheque/ui/screens/home/home_tab.dart';
import 'package:bibliotheque/ui/screens/wishlist/wish_list_screen.dart';
import 'package:bibliotheque/ui/widgets/books_list_page.dart';
import 'package:flutter/material.dart';

final globalHomeScreenKey = GlobalKey<HomeScreenState>();

class HomeScreen extends StatefulWidget {
  final _pages = [
    const HomeTab(),
    const BooksListPage(
      title: "Top popular",
      booksSource: BooksSource.popular,
    ),
    const WishListScreen(),
    const HomeTab(),
  ];
  HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedTap = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalHomeScreenKey,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedTap,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Icon(
              Icons.support,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Wish list',
            icon: Icon(
              Icons.description,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(
              Icons.supervised_user_circle_sharp,
            ),
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
