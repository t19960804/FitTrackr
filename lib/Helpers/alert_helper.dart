import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class AlertHelper {
  static void showAlert(BuildContext context,
      {required void Function()? deleteAction,
      required void Function()? cancelAction}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        const title = "Delete training";
        const content = "This operation can't redo";
        const btnDeleteTitle = "Delete";
        const btnCancelTitle = "Cancel";

        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: cancelAction,
                child: const Text(
                  btnCancelTitle,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              CupertinoDialogAction(
                onPressed: deleteAction,
                child: const Text(
                  btnDeleteTitle,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text(title),
            content: const Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: cancelAction,
                child: const Text(btnCancelTitle),
              ),
              TextButton(
                onPressed: deleteAction,
                child: const Text(btnDeleteTitle),
              ),
            ],
          );
        }
      },
    );
  }
}
