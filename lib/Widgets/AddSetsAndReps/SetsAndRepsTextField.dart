import 'package:flutter/material.dart';

class SetsAndRepsTextField extends StatelessWidget {
  const SetsAndRepsTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 25,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: Colors.blue), // 文字標籤的顏色
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: 4.0), // 非聚焦時的下劃線顏色和粗度
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: 4.0), // 聚焦時的下劃線顏色和粗度
        ),
      ),
      onChanged: (value) {},
    );
  }
}
