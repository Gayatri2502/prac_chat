 import 'package:flutter/material.dart';


 var textInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white30,
  hintStyle:  const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600
  ),
  focusedBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.black
    )
  ),
  errorBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      width: 2,
      color: Colors.red
    )
  ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      width: 2,
      color : Colors.teal.shade900
    )
)

);

 void showSnackbar(context, color, message){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(message, style: const TextStyle(
       fontSize: 14
     ),),
     backgroundColor: color,
       action: SnackBarAction(
         label: "OK",
         onPressed: (){},
         textColor: Colors.white,
       ),
     )
   );
 }
