import 'package:college/constants.dart';
import 'package:college/screens/halls_page.dart';
import 'package:college/screens/map_page.dart';
import 'package:college/screens/register_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/reusable_button.dart';
import 'home_page.dart';
GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;
String email;
String password;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),          backgroundColor: Colors.white,
      body: Builder(
        builder: (context){
        return ListView(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [


                  Image.asset('images/college.jpg',),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return 'please enter a proper email format example@ex.ex';
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'enter your Email')),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          // ignore: missing_return

                            textAlign: TextAlign.center,
                            obscureText: true,
                            onChanged: (value) {
                              password = value;
                              //Do something with the user input.
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 8) {
                                return 'password must be more than 8 characters';
                              } else return null;
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'enter your password')),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                   ButtonWidget(
                     myColor: Colors.teal,
                     myText: 'Log in',
                     onPressed: () async{

                       var connectResult =
                       await (Connectivity().checkConnectivity());
                       if ((connectResult != ConnectivityResult.wifi) &&
                           (connectResult != ConnectivityResult.mobile)) {
                         final snackBar = SnackBar(
                             content: Text(
                               'you don\'t have an internet connection',
                               style: TextStyle(color: Colors.black54),
                             ),
                             backgroundColor: Colors.lightBlueAccent,
                             action: SnackBarAction(
                               label: 'got it',
                               textColor: Colors.white,
                               onPressed: () {
                                 Scaffold.of(context).hideCurrentSnackBar();
                               },
                             ));
                         Scaffold.of(context).showSnackBar(snackBar);
                       } else {
                         try {
                           setState(()  {
                             showSpinner = true;
                           });
                           if (_formKey.currentState.validate()) {
                             final user =
                                 await _auth.signInWithEmailAndPassword(
                                 email: email, password: password);

                             //Implement login functionality.
                             if (user != null) {
                               if (email=='admin@gmail.com'){

                                 Navigator.push(
                                     context, MaterialPageRoute(builder: (context) {
                                   return HallsPage();
                                 },));
                               }
                               else {

                                 Navigator.push(
                                     context, MaterialPageRoute(builder: (context) {
                                   return HomePage();
                                 },));
                               }
                             }
                           }
                           setState(() {
                             showSpinner = false;
                           });
                         } catch (e) {
                           print(e);
                           if (e.toString().contains('no user')) {
                             final snackBar = SnackBar(
                                 content: Text(
                                   'this email doesn\'t exist',
                                   style: TextStyle(color: Colors.black54),
                                 ),
                                 backgroundColor: Colors.lightBlueAccent,
                                 action: SnackBarAction(
                                   label: 'got it',
                                   textColor: Colors.white,
                                   onPressed: () {
                                     Scaffold.of(context)
                                         .hideCurrentSnackBar();
                                   },
                                 ));
                             setState(() {
                               showSpinner = false;
                             });
                             Scaffold.of(context).showSnackBar(snackBar);
                           }
                         }
                       }
                     },
                   ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text('don\'t have an account ?',style: TextStyle(color:Colors.blue,fontSize: 16)),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) { return Registeration();}));
                        },
                        child: Text('Register here',style: TextStyle(color:Colors.blue ,decoration: TextDecoration.underline,fontSize: 20,fontWeight: FontWeight.bold)),
                      )
                    ],
                  )

          ],
        );}
      ),
    );
  }
}
