//파란색은 다 클래스 이름임.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var id  =user!.email;
    return Drawer(
      backgroundColor: const Color(0xffece6cc),
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: ListTile(
                    title: Text(
                      id!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop; //Drawer를 닫고 push
                  Navigator.pushNamed(context, '/now_emotion');
                },
                leading: const Icon(Icons.insert_emoticon),
                title: const Text(
                  "감정입력",
                ),
                tileColor: const Color(0xffece6cc)
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop; //Drawer를 닫고 push
                  Navigator.pushNamed(context, '/input_place');
                },
                leading: const Icon(Icons.place),
                title: const Text(
                  "장소입력",
                ),
                  tileColor: const Color(0xffece6cc)
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop; //Drawer를 닫고 push
                  Navigator.pushNamed(context, '/closet');
                },
                leading: const Icon(Icons.folder_open),
                title: const Text(
                  "옷장",
                ),
                  tileColor: const Color(0xffece6cc)
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop; //Drawer를 닫고 push
                  Navigator.pushNamed(context, '/calender');
                },
                leading: const Icon(Icons.calendar_month),
                title: const Text(
                  "달력",
                ),
                  tileColor: const Color(0xffece6cc)
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop; //Drawer를 닫고 push
                  Navigator.pushNamed(context, '/profile');
                },
                leading: const Icon(Icons.account_circle),
                title: const Text(
                  "MY",
                ),
                  tileColor: const Color(0xffece6cc)
              ),
            ],
          ),
    );
  }
}