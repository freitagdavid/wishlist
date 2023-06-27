import 'package:flutter/material.dart';

class WishListItem extends StatelessWidget {
  final String title;
  final String id;
  final void Function(String id) handleDelete;
  final void Function(String id) handleMoveUp;
  final void Function(String id) handleMoveDown;

  const WishListItem(
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
