import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/shared_screens/bottombar.dart';
import 'package:untitled/models/model_input_emotion.dart';
import '../../models/model_place_clothes_recommend.dart';

class RecommendPlaceDetail extends StatefulWidget {
  final int index;

  RecommendPlaceDetail({Key? key, required this.index}) : super(key: key);

  @override
  _RecommendPlaceDetailState createState() => _RecommendPlaceDetailState();
}

class _RecommendPlaceDetailState extends State<RecommendPlaceDetail> {
  Map<String, List<String>> selectedOutfitUrls = {};

  Future<void> _sendDataToServer(String id, String hopeEmotion, String placeName, String placeLocation, Map<String, List<String>> outfitUrls) async {
    var url = Uri.parse('http://34.170.39.54:6000/choose');

    Map<String, dynamic> data = {
      'id': id,
      'he': hopeEmotion,
      'placeName': placeName,
      'placeLocation': placeLocation,
      'outfitUrls': outfitUrls,
    };
    var body = json.encode(data);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to send data value to the server');
    }
  }

  Widget _buildCategorySection(String categoryName, List<String> outfitUrls, Function(String, String) handleSelection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            categoryName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (String outfitUrl in outfitUrls)
                GestureDetector(
                  onTap: () {
                    handleSelection(categoryName, outfitUrl);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: selectedOutfitUrls.containsKey(categoryName) && selectedOutfitUrls[categoryName]!.contains(outfitUrl)
                            ? Colors.green
                            : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            outfitUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Checkbox(
                          value: selectedOutfitUrls.containsKey(categoryName) &&
                              selectedOutfitUrls[categoryName]!.contains(outfitUrl),
                          onChanged: (value) {
                            setState(() {
                              if (selectedOutfitUrls.containsKey(categoryName)) {
                                if (!selectedOutfitUrls[categoryName]!.contains(outfitUrl)) {
                                  selectedOutfitUrls[categoryName]!.add(outfitUrl);
                                }
                              } else {
                                selectedOutfitUrls[categoryName] = [outfitUrl];
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var inputEmotionModel = Provider.of<InputEmotionModel>(context);
    var placeClothesRecommendModel = Provider.of<PlaceClothesRecommendModel>(context);
    var recommendationSets = placeClothesRecommendModel.recommendationSets;

    var hopeEmotion = inputEmotionModel.emotion;
    var placeName = recommendationSets[widget.index]['placeName'];
    var placeLocation = recommendationSets[widget.index]['placeLocation'];
    var placeDescription = recommendationSets[widget.index]['placeDescription'];
    var outfitUrlsSets = recommendationSets[widget.index]['outfitUrlsSets'] as Map<String, List<String>>;

    var id = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('장소 상세 정보'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '장소 이름: $placeName',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '장소 위치: $placeLocation',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '장소 설명: $placeDescription',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
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
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      for (var entry in outfitUrlsSets.entries)
                                        _buildCategorySection(entry.key, entry.value, (categoryName, outfitUrl) {
                                          setState(() {
                                            if (selectedOutfitUrls.containsKey(categoryName)) {
                                              if (!selectedOutfitUrls[categoryName]!.contains(outfitUrl)) {
                                                selectedOutfitUrls[categoryName]!.add(outfitUrl);
                                              }
                                            } else {
                                              selectedOutfitUrls[categoryName] = [outfitUrl];
                                            }
                                          });
                                        }),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: selectedOutfitUrls.isNotEmpty
                                      ? () {
                                    _sendDataToServer(
                                      id!,
                                      hopeEmotion,
                                      placeName,
                                      placeLocation,
                                      selectedOutfitUrls,
                                    );
                                    print(selectedOutfitUrls);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                      : null,
                                  child: Text('선택 완료'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Text('추천 옷차림'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
