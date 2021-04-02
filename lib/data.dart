import 'file:///D:/projects/college/lib/components/hall_search_suggestions.dart';
import 'package:flutter/material.dart';
class Data extends ChangeNotifier{
  bool isAdmin;
  List<HallSearchSuggestions> suggestions=[];
  void addSuggestion(HallSearchSuggestions suggestion){
    suggestions.add(suggestion);

  }

  List getList(){
    notifyListeners();
    return suggestions;
  }

  void makeAdmin(){
    isAdmin=true;
  }

  void notAdmin(){
    isAdmin=false;
  }
}