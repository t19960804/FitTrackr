import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final void Function() onTap;
  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Container(
            width: 15,
            height: 3,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
