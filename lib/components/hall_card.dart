import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HallCard extends StatelessWidget {
  HallCard({this.endHour,this.professor,this.startHour,this.subject,this.id,this.isAdmin});
  final String startHour;
  final String endHour;
  final String professor;
  final String subject;
  final String id;
  final bool isAdmin;
  final _firestoreVar = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
          children: [
            Row(
              children: [
                Text('From',style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(width: 30,),
                Container(padding: EdgeInsets.all(5),color: Colors.white,child: Text(startHour.toString(),style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),),
                SizedBox(width: 30,),
                Text('To',style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(width: 30,),
                Container(padding: EdgeInsets.all(5),color: Colors.white,child: Text(endHour.toString(),style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),),
              ],
            ),
            SizedBox(height: 30,),

            Row(
              children: [
                Container(padding: EdgeInsets.all(5),color: Colors.white,child: Text(professor.toString(),style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),),
                SizedBox(width: 30,),
                Container(padding: EdgeInsets.all(5),color: Colors.white,child: Text(subject.toString(),style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),),
                SizedBox(height: 30,),

              ],
            ),
            isAdmin?
            Row(
              children: [
                SizedBox(width: 250,),
                GestureDetector(child: Icon(Icons.edit,color: Colors.teal,size: 30,),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditScreen(docId: id,add: false,);
                  },));
                },),
                SizedBox(width: 30,),
                GestureDetector(child: Icon(Icons.delete,color: Colors.red,size: 30,),onTap: (){
                  Alert(
                      context: context,
                      title: 'sure you want to delete ? ',
                      buttons: [
                        DialogButton(
                          child: Text('delete'),
                          onPressed: () {
                            _firestoreVar.collection('halls').doc(id).delete();
                            Navigator.pop(context);
                          },
                        ),

                        DialogButton(
                          child: Text('cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ]).show();

                },),
              ],
            ) : Container(width: 1,height: 1,color: Colors.grey.shade200,) ,

            Divider(
              color: Colors.blue,
            )
          ],
        ),
      )
    ;
  }
}
