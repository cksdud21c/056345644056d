import 'package:flutter/material.dart';

class Bottombar extends StatefulWidget {
  @override
  _BottombarState createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 현재 페이지에 따라 _currentIndex 값을 설정
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == '/calender') {
      _currentIndex = 1;
    } else if (currentRoute == '/closet') {
      _currentIndex = 2;
    } else if( currentRoute == '/profile'){
      _currentIndex = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 44,
      backgroundColor : const Color(0xffece6cc),
      currentIndex: _currentIndex,
      onTap: (index) {
        // Handle navigation based on the index
        if (index == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (index == 1) {
          Navigator.of(context).pushNamed('/calender');
        } else if (index == 2) {
          Navigator.of(context).pushNamed('/closet');
        } else if( index == 3){
          Navigator.of(context).pushNamed('/profile');
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '달력'),
        BottomNavigationBarItem(icon: Icon(Icons.circle), label: '옷장'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54.withOpacity(0.60),
    );
  }
}
