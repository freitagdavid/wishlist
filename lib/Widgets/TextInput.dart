import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String? initialValue;
  final TextEditingController inputController;
  final void Function() handleAdd;

  const TextInput(
      {super.key,
      required this.inputController,
      required this.handleAdd,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        FloatingActionButton(
          onPressed: handleAdd,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
