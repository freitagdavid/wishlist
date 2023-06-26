import 'dart:collection';

import 'package:wish_list/models/WishListItemData.dart';

class WishList {
  List<WishListItemData> items = [];

  _sort() {
    items.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
  }

  insert(title) {
    items.insert(0, WishListItemData(title: title));
  }

  remove(id) {
    items.removeWhere((item) => item.id == id);
  }

  moveUp(id) {
    var index = items.indexWhere((item) => item.id == id);
    items[index].timeStamp =
        items[index].timeStamp.add(const Duration(days: 1));
    items.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
  }

  moveDown(id) {
    var index = items.indexWhere((item) => item.id == id);
    items[index].timeStamp =
        items[index].timeStamp.subtract(const Duration(days: 1));
    items.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
  }

  map(fn) {
    return items.map((WishListItemData item) => fn(item)).toList();
  }

  List<WishListItemData> get() {
    _sort();
    return items;
  }
}

class WishList2 extends ListBase<WishListItemData> {
  
  const WishList2({super()})

  _sort() {
    sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
  }

  insertItem(String title) {
    add(WishListItemData(title: title));
  }

  removeItem(String id) {
    removeWhere((item) => item.id == id);
  }

  moveItemUp(String id) {
    var index = indexWhere((item) => item.id == id);
    this[index].timeStamp = this[index].timeStamp.add(const Duration(days: 1));
    _sort();
  }

  moveItemDown(String id) {
    var index = indexWhere((item) => item.id == id);
    this[index].timeStamp =
        this[index].timeStamp.subtract(const Duration(days: 1));
    _sort();
  }
}
