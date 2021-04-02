import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../components/hall_search_suggestions.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';

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
