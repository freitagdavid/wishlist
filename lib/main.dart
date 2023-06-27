import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:wish_list/Widgets/WishListItem.dart';
import 'package:wish_list/Widgets/TextInput.dart';
// import 'package:wish_list/models/WishList.dart';

const uuid = Uuid();

final listStorage = SharedPreferences.getInstance();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wish List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

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

// persist(wishList) {
//   listStorage.setStringList(
//       'wishList', wishList.map((item) => item.toString()));
// }

// load() {
//   var wishList = listStorage.getStringList('wishList');
//   if (wishList == null) {
//     return [];
//   }
//   return wishList
//       .map((item) => WishListItemData(title: item['title']))
//       .toList();
// }

class _MyHomePageState extends State<MyHomePage> {
  var wishList = [];
  var inputController = TextEditingController();
  // var wishList2 = WishList2();

  void handleAdd() {
    setState(() {
      var wishListItem = WishListItemData(title: inputController.text);
      wishList.add(wishListItem);
      inputController.clear();
    });
  }

  void _removeItem(String id) {
    setState(() {
      wishList.removeWhere((item) => item.id == id);
    });
  }

  void _moveItemUp(String id) {
    setState(() {
      var index = wishList.indexWhere((item) => item.id == id);
      wishList[index].timeStamp =
          wishList[index].timeStamp.add(const Duration(days: 1));
      wishList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
    });
  }

  void _moveItemDown(String id) {
    setState(() {
      var index = wishList.indexWhere((item) => item.id == id);
      wishList[index].timeStamp =
          wishList[index].timeStamp.subtract(const Duration(days: 1));
      wishList.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      print(wishList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      // child: ListView(
                      //   children: _buildWishList(),
                      child: ListView.builder(
                        itemCount: wishList.length,
                        itemBuilder: (context, index) {
                          return WishListItem(
                            title: wishList[index].title,
                            id: wishList[index].id,
                            handleDelete: (id) => _removeItem(id),
                            handleMoveUp: (id) => _moveItemUp(id),
                            handleMoveDown: (id) => _moveItemDown(id),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextInput(
                inputController: inputController,
                handleAdd: handleAdd,
              ),
              SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }
}
