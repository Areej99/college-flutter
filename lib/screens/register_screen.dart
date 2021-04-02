import 'package:college/components/reusable_button.dart';

import '../constants.dart';
import 'file:///D:/projects/college/lib/screens/login_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class Registeration extends StatefulWidget {
  @override
  _RegisterationState createState() => _RegisterationState();
}
GlobalKey<FormState> _formKey = new  GlobalKey<FormState>();
final _firestoreVar = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
String email;
String password;

class _RegisterationState extends State<Registeration> {
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text(
           'Register',
           style: TextStyle(
               color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
         ),
       ),      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Image.asset('images/college.jpg',),
                    Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
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
                                } else
                                  return null;
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
                      myText: 'Register',
                      onPressed: () async {
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
                            setState(() {
                              showSpinner = true;
                            });
                            if (_formKey.currentState.validate()) {
                              final user =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);

                              //Implement login functionality.
                              if (user != null) {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                },));
                              }
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
                            if (e.toString().contains('already in use')) {
                              final snackBar = SnackBar(
                                  content: Text(
                                    'this email already exists',
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
                        Text('already have an account ? ',
                          style: TextStyle(color: Colors.blue, fontSize: 16),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) {
                              return LoginPage();
                            }));
                          },
                          child: Text(' log in here ', style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize:  20,fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
          ;
        }
      ),
    );
  }
}
