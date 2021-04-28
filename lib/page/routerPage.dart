import 'package:avokadio/theme/themeColor.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';

class RouterPage extends StatefulWidget {
  @override
  _RouterPageState createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  List<Widget> _screen = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onPageChanged(int index) {}

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }
Widget getBottomNavigationBar(){
  return BottomNavigationBar(
        unselectedFontSize: 14.0,
        selectedItemColor: AvokadioTheme.background,
        unselectedItemColor: AvokadioTheme.background,
        type: BottomNavigationBarType.fixed,
        

        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Anasayfa")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Arama")),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), title: Text("Yemek")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Profil")),
        ],
      );
}
}




