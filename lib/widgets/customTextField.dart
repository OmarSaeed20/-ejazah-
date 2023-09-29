import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
    late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    
    return Container  (
      padding: EdgeInsets.all(8),
      width: 350,
      height: 60,
      color: Color.fromARGB(255, 247, 247, 247),
      child: TextFormField(
        enableInteractiveSelection: true,
        keyboardType: TextInputType.emailAddress,
        cursorHeight: 25,
        cursorWidth: 2,
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.call,
              color: Colors.black45,
            ),
            hintText: 'رقم الهاتـف',
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none),
      ),
    );
  

  }
}