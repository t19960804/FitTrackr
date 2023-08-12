import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final bool canBePressed;
  final void Function() onPressed;
  const FinishButton(
      {super.key, required this.canBePressed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: canBePressed ? Colors.black : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: canBePressed
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      height: 65,
      child: TextButton(
        onPressed: () {
          if (canBePressed) {
            onPressed();
            Navigator.pop(context);
          }
        },
        child: const Text(
          "Finish",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
