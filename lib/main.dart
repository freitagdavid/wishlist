import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:wish_list/models/WishList.dart';

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
  var wishList2 = WishList2();

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

  List<Widget> _buildWishList() {
    return wishList2
        .map((WishListItemData item) => WishListItem(
              title: item.title,
              id: item.id,
              handleDelete: (id) => _removeItem(id),
              handleMoveUp: (id) => _moveItemUp(id),
              handleMoveDown: (id) => _moveItemDown(id),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                child: TextField(
                  controller: inputController,
                  onSubmitted: (value) => handleAdd(),
                ),
              ),
            ),
            Container(
              child: FloatingActionButton(
                onPressed: handleAdd,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class WishListItem extends StatelessWidget {
  String title;
  String id;
  void Function(String id) handleDelete;
  void Function(String id) handleMoveUp;
  void Function(String id) handleMoveDown;

  WishListItem(
      {super.key,
      required this.title,
      required this.id,
      required this.handleDelete,
      required this.handleMoveUp,
      required this.handleMoveDown});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  IconButton(
                      onPressed: () => handleMoveUp(id),
                      icon: const Icon(Icons.arrow_upward)),
                  IconButton(
                      onPressed: () => handleMoveDown(id),
                      icon: const Icon(Icons.arrow_downward)),
                  IconButton(
                    onPressed: () => handleDelete(id),
                    icon: const Icon(Icons.delete),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
