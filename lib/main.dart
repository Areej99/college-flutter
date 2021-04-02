import 'package:cloud_firestore/cloud_firestore.dart';

import 'components/hall_search_suggestions.dart';
import 'file:///D:/projects/college/lib/screens/splash_screen.dart';
import 'package:college/screens/login_page.dart';
import 'package:college/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'package:splashscreen/splashscreen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



List<HallSearchSuggestions> suggestions = [];
final _firestoreVar = FirebaseFirestore.instance;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new LoginPage(),
      title: new Text(
        'College',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            color: Colors.deepPurple),
      ),
      image: new Image.asset('images/college.jpg'),
      photoSize: 100,
      backgroundColor: Colors.white,
      loaderColor: Colors.blue,
    );
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Data>(
      builder :(BuildContext context) => Data()  ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

