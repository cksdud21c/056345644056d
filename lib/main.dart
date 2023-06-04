import 'package:flutter/material.dart';
import 'package:untitled/models/model_auth.dart';
import 'package:untitled/models/model_register.dart';
import 'package:untitled/models/model_login.dart';


import 'package:untitled/models/model_input_emotion.dart';
import 'models/model_place_clothes_recommend.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_login.dart';
import 'screens/screen_register.dart';
import 'screens/input_emotion_screens/screen_now_emotion.dart';
import 'screens/input_emotion_screens/screen_hope_emotion.dart';
import 'screens/input_place_screens/screen_input_place.dart';
import 'screens/input_place_screens/screen_recommend_clothes.dart';
import 'screens/input_emotion_screens/screen_recommend_place.dart';
import 'package:untitled/tabs/tab_calender.dart';
import 'package:untitled/tabs/tab_profile.dart';
import 'package:untitled/screens/closet_screens/screen_closet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_options.dart';

import 'package:untitled/screens/closet_screens/screen_camera.dart';
import 'package:untitled/screens/screen_home.dart';
import 'package:untitled/screens/screen_info.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:untitled/models/model_input_place.dart';
import 'package:untitled/models/model_clothes_recommend.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => RegisterModel()),
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => InputEmotionModel()),
        ChangeNotifierProvider(create: (_) => InputPlaceModel()),
        ChangeNotifierProvider(create: (_) => PlaceClothesRecommendModel()),
        ChangeNotifierProvider(create: (_) => ClothesRecommendModel()),
      ],
      child: MaterialApp(
        routes: {
          '/splash': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/now_emotion' : (context) => NowEmotionScreen(),
          '/hope_emotion' : (context) => HopeEmotionScreen(),
          '/closet' : (context) => ClosetScreen(),
          '/calender' : (context) => TabCalender(),
          '/profile' : (context) => TabProfile(),
          '/input_place' : (context) => InputPlaceScreen(),
          '/camera' : (context) => CameraScreen(),
          '/home' : (context) =>HomeScreen(),
          '/info' : (context) => InfoScreen(),
          '/screen_recommend_clothes' : (context) => RecommendClothesScreen(),
          '/screen_recommend_place' : (context) => RecommendPlaceScreen(),
        },
        theme : ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: const Color(0xffece6cc), // AppBar의 기본 배경색상 변경
              foregroundColor: Colors.black, // AppBar의 기본 글자색 변경
            ),
            scaffoldBackgroundColor: const Color(0xffece6cc),
            fontFamily:"jeju"),
        initialRoute: '/splash',
        builder: (context, child) {
          return DefaultTextStyle(
            style: TextStyle(
              color: Colors.black, // 글자색을 검정색으로 설정
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
