import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/screens/shared_screens/menu.dart';
import 'package:provider/provider.dart';
import '../../models/model_clothes_recommend.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/model_input_place.dart';
class RecommendClothesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var clothesRecommendModel = Provider.of<ClothesRecommendModel>(context, listen: false);
    var auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var id  =user!.email;
    var inputPlaceModel = Provider.of<InputPlaceModel>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
        title: Text('추천 옷차림'),
      ),
      endDrawer: SafeArea(
        child: Menu(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => buildRecommendationDialog(context,clothesRecommendModel.recommendationSets[0]),
                );
              },
              child: buildRecommendationContainer('추천 옷차림 1'),
            ),
            ElevatedButton(
              onPressed: () {
                saveOutfit(context, id!, inputPlaceModel.place, inputPlaceModel.district, clothesRecommendModel.recommendationSets[0]);
              },
              child: Text('옷차림1 저장',style: TextStyle(color: Colors.black)),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => buildRecommendationDialog(context, clothesRecommendModel.recommendationSets[1]),
                );
              },
              child: buildRecommendationContainer('추천 옷차림 2'),
            ),
            ElevatedButton(
              onPressed: () {
                saveOutfit(context, id!, inputPlaceModel.place, inputPlaceModel.district,clothesRecommendModel.recommendationSets[1]);
              },
              child: Text('옷차림2 저장',style: TextStyle(color: Colors.black)),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => buildRecommendationDialog(context, clothesRecommendModel.recommendationSets[2]),
                );
              },
              child: buildRecommendationContainer('추천 옷차림 3'),
            ),
            ElevatedButton(
              onPressed: () {
                saveOutfit(context, id!, inputPlaceModel.place, inputPlaceModel.district,clothesRecommendModel.recommendationSets[2]);
              },
              child: Text('옷차림3 저장',style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottombar(),
    );
  }

  Widget buildRecommendationContainer(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
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
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  Widget buildRecommendationDialog(BuildContext context, List<String> recommendationSet) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('추천 옷차림'),
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

  Future<void> saveOutfit(BuildContext context, String id, String placeName, String district, List<String> recommendationSet) async {
    var url = Uri.parse('http://34.170.39.54:6000/????');
    var data = {'id': id, 'district' : district, 'placename' : placeName , 'outfiturls': recommendationSet};
    var body = json.encode(data);
    var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Outfit saved!'),
        ),
      );
      // Navigate to the home screen
      Navigator.pushNamed(context, '/home');
      return ;
    } else {
      throw Exception('Failed to send data value to the server');
    }
  }
}
