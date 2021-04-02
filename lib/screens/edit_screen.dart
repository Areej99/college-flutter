import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/components/hour_widget.dart';
import 'package:college/components/reusable_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

//make the functionality
class EditScreen extends StatefulWidget {
  EditScreen({this.docId, this.add});
  final String docId;
  final bool add;
  @override
  _EditScreenState createState() => _EditScreenState();
}

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
final _firestoreVar = FirebaseFirestore.instance;

class _EditScreenState extends State<EditScreen> {
  String professor;
  String subject;
  int to = 10;
  int from = 9;
  String hall = 'hall 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.add ? 'Edit' : 'add',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'please choose a hall',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  DropdownButton<String>(
                    //isExpanded: true,
                    hint: Text('chooose'),
                    value: hall,
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.blue,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        hall = newValue;
                      });
                    },
                    items: <String>[
                      'hall 1',
                      'hall 2',
                      'hall 3',
                      'hall 4',
                      'hall 5',
                      'hall 6',
                      'hall 7',
                      'hall 8'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a value';
                              }
                            },
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              professor = value;
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'enter a professor name')),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                            // ignore: missing_return

                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              subject = value;
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter a value';
                              } else
                                return null;
                            },
                            decoration: kInputDecoration.copyWith(
                                hintText: 'enter a subject name')),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    from--;
                                  });
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 15,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 25,
                                    ))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              from.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    from++;
                                  });
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 15,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    to--;
                                  });
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 15,
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 25,
                                    ))),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              to.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    to++;
                                  });
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 15,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 25,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          myColor: Colors.blue,
                          myText: 'Save',
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (widget.add) {
                                _firestoreVar.collection('halls').add({
                                  'to': to.toString(),
                                  'from': from.toString(),
                                  'professor': professor,
                                  'subject': subject,
                                  'hall': hall
                                });
                              } else {
                                //update data;
                                _firestoreVar
                                    .collection('halls')
                                    .doc(widget.docId)
                                    .set({
                                  'to': to.toString(),
                                  'from': from.toString(),
                                  'professor': professor,
                                  'subject': subject,
                                  'hall': hall
                                });
                              }
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
