import 'package:bibliotheque/ui/screens/home/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final _pages = [
    const HomeTab(),
    const HomeTab(),
    const HomeTab(),
    const HomeTab(),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
}
