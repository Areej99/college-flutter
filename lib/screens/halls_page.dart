import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/hall.dart';
import 'edit_screen.dart';

// ignore: must_be_immutable
class HallsPage extends StatelessWidget {
  List<Hall> hallsList = [];
  List<Hall> getList() {
    for (int i = 1; i < 9; i++) {
      hallsList.add(Hall(
        hallName: ('hall ' + i.toString()),
        isAdmin: true,
      ));
    }
    return hallsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'halls',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: getList() ,
                  padding: EdgeInsets.all(15),
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 30,
                  childAspectRatio: 2,
                ),
                SizedBox( height: 40,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return EditScreen(docId: '0',add: true,);   //change the functionality if it's add
                    },));
                  },
                  child: Container(
                    width: 100,
                    height: 70,
                    color: Colors.blue.shade900,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
        // child: ListView(
        //   shrinkWrap: true,
        //   children: getList(),
        // ),
      ),
    );
  }
}
