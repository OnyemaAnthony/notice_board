import 'package:flutter/material.dart';
import 'package:notice_board/models/user_model.dart';
import 'package:notice_board/screens/account_screen.dart';
import 'package:notice_board/screens/home_screen.dart';
import 'package:notice_board/screens/my_notice_screen.dart';
import 'package:notice_board/widgets/storage.dart';
class NavigationScreen extends StatefulWidget {
  final UserModel? user;
  const NavigationScreen({Key? key,this.user}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int currentIndex = 0;
  void onTap(int selectedIndex){
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const MyNoticeScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',tooltip: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.circle_notifications),label: 'My Notice',tooltip: 'My Notice'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Account',tooltip: 'Account'),
        ],
      ),
    );
  }
}
