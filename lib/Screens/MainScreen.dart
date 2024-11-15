import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixappassignment/Constants/colors.dart';
import 'package:netflixappassignment/Screens/HomeScreen.dart';
import 'package:netflixappassignment/Screens/SearchScreen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
    int _currentIndex = 0;
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = Get.arguments;
    if (args != null && args['currentindex'] != null) {
      setState(() {
        _currentIndex = args['currentindex'];
      });
    }
  }
  // List of screens for navigation
  final List<Widget> _screens = [
    const Homescreen(), 
    const Searchscreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ConstColors.bottomNavigation,
      body: _screens[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        backgroundColor: Colors.transparent,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}