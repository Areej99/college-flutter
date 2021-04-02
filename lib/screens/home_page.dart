import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/components/reusable_button.dart';
import '../data.dart';
import 'file:///D:/projects/college/lib/components/hall_search_suggestions.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
//import 'package:provider/provider.dart';
import 'map_page.dart';

String selectedEntry = 'entry 1';
String entry;
String hall;

final _firestoreVar = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HallSearchSuggestions> suggestions = [];

  GlobalKey<AutoCompleteTextFieldState<HallSearchSuggestions>> key =
      new GlobalKey();
  Widget row(HallSearchSuggestions suggestion) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            suggestion.forSearch,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
//   void getData() async {
//     await for (var snapshot in _firestoreVar.collection('halls').snapshots()) {
//       for (var message in snapshot.docs) {
//         print(message.data()['professor']);
//       }
//     }
//   }
// @override
//   void initState() {
//    getData();
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    AutoCompleteTextField<HallSearchSuggestions> searchTextField;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            )),
      ),
      body: ListView(
        children: [
          Container(
            height: 5,
            width: 5,
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestoreVar.collection("halls").snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final hallInfo = snapshot.data.docs; //gets the last message
                    for (var info in hallInfo) {
                      final hallName = info.data()['hall'].toString();
                      final professor = info.data()['professor'];
                      final subject = info.data()['subject'];
// ignore: missing_return
                      final hallSuggestion1 = new HallSearchSuggestions(
                        hall: hallName.substring(hallName.length - 1),
                        forSearch: professor,
                      );
                      final hallSuggestion2 = new HallSearchSuggestions(
                        hall: hallName.substring(hallName.length - 1),
                        forSearch: subject,
                      );
                      // print(hallName.substring(hallName.length-1));
                      // print(professor);
                      // print(subject);
                      // print('--------------------------------------------');

                      suggestions.add(hallSuggestion1);
                      suggestions.add(hallSuggestion2);
                      print(
                          '-------------------------------------------------------------------');
        //print(suggestions[0]);
                      //providerVar.addSuggestion(hallSuggestion1);
                      //providerVar.addSuggestion(hallSuggestion2);
                    }
                    return Container();
                  } else {
                    print(
                        '-------------------------------------------------------------------');
                    return Container();
                  }
                }),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Image.asset(
                    'images/search.jpeg',
                    height: 300,
                    width: 300,
                  )),
              Text('Choose Entry :',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              // Container(
              //   padding: EdgeInsets.only(left: 20),
              //   height: 50,
              //   width: 120,
              //   child: DropdownButton(
              //     iconSize: 30,
              //     items: [
              //       DropdownMenuItem(
              //         child: Text(
              //           'entry 1',
              //           style: TextStyle(fontSize: 20),
              //         ),
              //         value: '1',
              //       ),
              //       DropdownMenuItem(
              //         child: Text('entry 2', style: TextStyle(fontSize: 20)),
              //         value: '2',
              //       ),
              //       DropdownMenuItem(
              //         child: Text('entry 3', style: TextStyle(fontSize: 20)),
              //         value: '3',
              //       ),
              //       DropdownMenuItem(
              //         child: Text('entry 4', style: TextStyle(fontSize: 20,color: Colors.red)),
              //         value: '4',
              //       ),
              //     ],
              //     hint: Text(selectedEntry, style: TextStyle(fontSize: 20)),
              //     onChanged: (val) {
              //       setState(() {
              //         selectedEntry = 'entry ' + val;
              //         entry = val.toString();
              //       });
              //     },
              //   ),
              // ),
              //--------------------------------------------
              Padding(
                padding:  EdgeInsets.all(15.0),
                child: DropdownButton<String>(
                  //isExpanded: true,
                  hint: Text('chooose'),
                  value: selectedEntry,
                  icon: Icon(Icons.arrow_drop_down_circle,color: Colors.blue,),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      selectedEntry=newValue;
                       entry= selectedEntry.substring(selectedEntry.length-1);
                       print(entry);
                      // print(entry);
                    });
                  },
                  items: <String>['entry 1', 'entry 2', 'entry 3', 'entry 4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              //----------------------------------------------------
              Text('Find Hall :',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              searchTextField = AutoCompleteTextField<HallSearchSuggestions>(
                clearOnSubmit: false,
                key: key,
                suggestions:
                    suggestions, //Provider.of<Data>(context).getList(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'search with professor or subject name',
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                ),
                itemFilter: (item, query) {
                  return (item.forSearch
                      .toLowerCase()
                      .startsWith(query.toLowerCase()));
                },
                itemSorter: (a, b) {
                  return (a.forSearch.compareTo(b.forSearch));
                },
                itemBuilder: (context, item) {
                  return row(item);
                },
                itemSubmitted: (item) {
                  searchTextField.textField.controller.text = item.forSearch;
                  setState(() {
                    hall = item.hall;
                  });
                },
              ),
            ],
          ),
          ButtonWidget(
            myText: 'Search',
            myColor: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(
                      entryNum: entry,
                      hallNum: hall,
                    ),
                  ));
            },
          )
        ],
      ),
    );
  }
}

//_firestoreVar.collection('halls').get();
// _firestoreVar.collection('halls').add({
//   'to': '10',
//   'from':'8',
//   'professor':'sayed',
//   'subject':'database',
//   'hall':'hall 8'
// });
