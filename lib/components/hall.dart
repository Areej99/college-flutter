import 'file:///D:/projects/college/lib/screens/hall_info.dart';
import 'package:flutter/material.dart';

class Hall extends StatelessWidget {
  Hall({this.hallName,this.isAdmin});
  final String hallName;
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 20,
      color: Colors.blue.shade900,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HallInfo(
                hall: hallName,
                isAdmin: isAdmin,
              ),
            ),
          );
        },
        child: Card(
          color: Colors.blue.shade900,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
            child: Text(
              hallName,
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}
