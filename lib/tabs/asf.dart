//하단바의 달력버튼을 누르면 나오는 화면
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TabCalender extends StatefulWidget {
  @override
  State<TabCalender> createState() => _TabCalenderState();
}

class _TabCalenderState extends State<TabCalender> {
  // Define a variable to store the selected date
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  Map<DateTime, List<dynamic>> events = {};

  @override
  void initState() {
    super.initState();
    // Fetch events for the current month initially
    fetchEventsForMonth();
  }

  // void fetchEventsForMonth() async {
  //   var auth = FirebaseAuth.instance;
  //   var user = auth.currentUser;
  //   var id = user!.email;
  //
  //   var url = Uri.parse('http://34.66.37.198/getMonthData');
  //   var data = {'id': id};
  //   var body = json.encode(data);
  //   var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  //
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     List<dynamic> dates = List<dynamic>.from(responseData['dates']);
  //
  //     Map<DateTime, List<dynamic>> newEvents = {};
  //     for (var dateString in dates) {
  //       DateTime date = DateTime.parse(dateString);
  //       newEvents[date] = [];
  //     }
  //
  //     setState(() {
  //       events = newEvents;
  //     });
  //   }
  // }
  void fetchEventsForMonth() async {
    var a=1;
    if (a==1) {
      List<dynamic> dates = [
        "2023-06-01",
        "2023-06-05",
        "2023-06-10"
      ];

      Map<DateTime, List<dynamic>> newEvents = {};
      for (var dateString in dates) {
        DateTime date = DateTime.parse(dateString);
        newEvents[date] = [];
      }

      setState(() {
        events = newEvents;
      });
    }
  }
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
    });
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    var b=200;
    if (b== 200) {
      List<dynamic> sets = [
        {
          "emotion": "Happy",
          "placeName": "Park",
          "outfitUrls": [
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg",
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg",
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg"
          ]
        },
        {
          "emotion": "Sad",
          "placeName": "Cafe",
          "outfitUrls": [
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg",
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg",
            "https://image.msscdn.net/images/goods_img/20230524/3320672/3320672_16848947608515_500.jpg"
          ]
        }
      ];
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(formattedDate),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < sets.length; i++) buildSetBox(sets[i], i),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle errors in case the server request fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to get selected date data.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
  //   setState(() {
  //     this.selectedDay = selectedDay;
  //     this.focusedDay = focusedDay;
  //   });
  //
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
  //   var auth = FirebaseAuth.instance;
  //   var user = auth.currentUser;
  //   var id = user!.email;
  //
  //   var url = Uri.parse('http://34.66.37.198/getData');
  //   var data = {'id': id, 'date': formattedDate};
  //   var body = json.encode(data);
  //   var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  //
  //   if (response.statusCode == 200) {
  //     var responseData = json.decode(response.body);
  //     List<dynamic> sets = List<dynamic>.from(responseData['sets']);
  //
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(formattedDate),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 for (int i = 0; i < sets.length; i++) buildSetBox(sets[i], i),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Close'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } else {
  //     // Handle errors in case the server request fails
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to get selected date data.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Close'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Widget buildSetBox(Map<String, dynamic> set, int index) {
    String emotion = set['emotion'];
    String placeName = set['placeName'];
    List<String> outfitUrls = List<String>.from(set['outfitUrls']);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildDetailDialog(context, emotion, placeName, outfitUrls);
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xffece6cc),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이용기록 ${index + 1}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailDialog(BuildContext context, String emotion, String placeName, List<String> outfitUrls) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('이용기록 세부 정보'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emotion: $emotion'),
                  Text('Place Name: $placeName'),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return buildRecommendationDialog(context, outfitUrls);
                        },
                      );
                    },
                    child: Text('View Outfit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecommendationDialog(BuildContext context, List<String> recommendationSet) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('결정한 옷 차림'),
              actions: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Column(
              children: [
                for (int i = 0; i < recommendationSet.length; i++)
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(
                          recommendationSet[i],
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            getRecommendationTitle(i),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getRecommendationTitle(int index) {
    // Return the recommendation title based on the index
    switch (index) {
      case 0:
        return 'Outer';
      case 1:
        return 'Top';
      case 2:
        return 'Bottom';
      case 3:
        return 'Shoes';
      case 4:
        return 'Acc';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 67, 117),
        title: Text('달력'),
      ),
      endDrawer: SafeArea(child: Menu()),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDay,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (DateTime day) {
          return isSameDay(selectedDay, day);
        },
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) => DateFormat.yMMMMd(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            color: Colors.blue,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leftChevronIcon: const Icon(
            Icons.arrow_left,
            size: 40.0,
          ),
          rightChevronIcon: const Icon(
            Icons.arrow_right,
            size: 40.0,
          ),
        ),
        calendarStyle: const CalendarStyle(
          isTodayHighlighted: true,
          todayTextStyle: TextStyle(
            color: Colors.black,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.amber,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            final hasEvents = events.isNotEmpty;
            return hasEvents
                ? Positioned(
              bottom: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${events.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
                : SizedBox();
          },
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }

}

