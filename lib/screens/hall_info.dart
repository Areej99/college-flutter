import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/hall_card.dart';

final _firestoreVar = FirebaseFirestore.instance;

class HallInfo extends StatefulWidget {
  HallInfo({this.hall,this.isAdmin});
  final String hall;
  final bool isAdmin;
  @override
  _HallInfoState createState() => _HallInfoState();
}

class _HallInfoState extends State<HallInfo> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.hall,style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestoreVar.collection("halls").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                ),
              );
            }
            else {
              final hallInfo = snapshot.data.docs; //gets the last message
              List<HallCard> cards = [];
              for (var info in hallInfo) {
                final id= info.id;
                final hallName = info.data()['hall'];
                if(hallName==widget.hall) {
                  final start = info.data()['from'];
                  final end = info.data()['to'];
                  final professor = info.data()['professor'];
                  final subject = info.data()['subject'];

// ignore: missing_return
                  final hallCard = HallCard(
                    endHour: end,
                    startHour: start,
                    professor: professor,
                    subject: subject,
                    id: id,
                    isAdmin: widget.isAdmin,
                  );

                  cards.add(hallCard);
                }
              }
              return ListView(
                // shrinkWrap: true,
//to scroll to the new message
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                children: cards,
              );
            }
          }
      ),
    );

  }
}
