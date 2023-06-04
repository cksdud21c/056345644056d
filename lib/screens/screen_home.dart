import 'package:flutter/material.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
class HomeScreen extends StatelessWidget {
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffece2be),
          title: Text('앱 사용 방법'),
          content: Text('먼저, 자신의 옷을 등록하세요:)\n\n''감정을 입력해 갈 장소와 입을 옷을 추천 받으세요:)\n\n''장소를 입력해 옷을 추천 받으세요:)\n\n''달력으로 앱 이용 기록을 확인해보세요:)'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // 아이콘 색상 변경
        ),
        title: Text('HMM'),
        leading: IconButton(
          icon: Icon(Icons.help,color: Colors.black),
          onPressed: () {
            _showHelpDialog(context);
          },
        ),
      ),
      endDrawer: SafeArea(child: Menu(),),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Image.asset('assets/images/gromit.png'),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/now_emotion');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 5),
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/gromit.png'),
                              const SizedBox(width: 2, height: 2),
                              const Text(
                                "감정 입력",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/input_place');
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black, width: 5),
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/images/gromit.png'),
                              const SizedBox(width: 2, height: 2),
                              const Text(
                                "장소 입력",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }
}
