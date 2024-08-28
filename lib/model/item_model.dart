import 'package:busan_trip/app_http/item_http.dart';
import 'package:flutter/material.dart';
import '../vo/item.dart';

class ItemModel extends ChangeNotifier {
  List<Item> items = [];


  Future<void> setItems() async{
    items = await ItemHttp.fetchAll();
    notifyListeners();
  }

  // home_screen 실시간 핫플레이스 5개 정렬(defaultValue = latest)
  Future<void> set5Items() async{
    items = await ItemHttp.fetch5Items();
    items.sort((a, b) => a.ui_rank.compareTo(b.ui_rank));
    notifyListeners();
  }
}