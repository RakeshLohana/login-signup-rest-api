import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 final  void Function(String)? onChanged;
 final  TextEditingController? controller;
  final String labelText;

  const CustomTextField({super.key, this.controller,this.onChanged,required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
    
     decoration: InputDecoration(

      
      labelText: labelText,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.purple),
       borderRadius: BorderRadius.circular(10),

    ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 224, 200, 228)),

  
       
        borderRadius: BorderRadius.circular(10))

     ),
    
      onChanged: onChanged,

    );
  }
}