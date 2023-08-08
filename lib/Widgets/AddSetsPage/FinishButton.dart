import 'package:flutter/material.dart';

class FinishButton extends StatelessWidget {
  final void Function() onPressed;
  const FinishButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      height: 65,
      child: TextButton(
        onPressed: () {
          onPressed();
          Navigator.pop(context);
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
