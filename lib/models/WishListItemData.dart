import 'package:uuid/uuid.dart';

const uuid = Uuid();

class WishListItemData {
  String title;
  String id = uuid.v4();
  DateTime timeStamp = DateTime.now();

  WishListItemData({
    required this.title,
  });

  @override
  toString() {
    return {
      'title': title,
      'id': id,
      'createdAt': timeStamp,
    }.toString();
  }
}
