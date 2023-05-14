import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 23.0,
    ),
    prefixIconColor: Colors.black,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.black, width: 2.0))

    // focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(width: 5, color: Colors.teal.shade900)),
    // errorBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(width: 2, color: Colors.red)),
    // enabledBorder: const OutlineInputBorder(
    //     borderSide: BorderSide(width: 2, color: Colors.black))
    );

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
