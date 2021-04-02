import 'package:flutter/material.dart';
class HourWidget extends StatefulWidget {
  HourWidget({this.number,this.txt});
   int number;
  final String txt;
  @override
  _HourWidgetState createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.txt,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
        SizedBox(width: 20,),
        GestureDetector(onTap: (){
          setState(() {
            widget.number --;
          });
        },child: CircleAvatar(backgroundColor: Colors.blue ,radius: 15,child: Icon(Icons.remove,color: Colors.white,size: 25,))),



        SizedBox(width: 20,),

        Text(widget.number.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
        SizedBox(width: 20,),

        GestureDetector(onTap: (){
          setState(() {
            widget.number ++;
          });
        },child: CircleAvatar(backgroundColor: Colors.blue ,radius: 15,child: Icon(Icons.add,color: Colors.white,size: 25,))),
      ],
    );
  }
}
