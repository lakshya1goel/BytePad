import 'package:flutter/material.dart';
import '../../theme_data.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  const CustomInputField({ required this.labelText, required this.icon, required this.controller,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextFormField(
        controller: controller,
        cursorColor: blueColor,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelStyle: TextStyle(
            color: blueColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blueColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(right: size.width*0.08),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: blueColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Icon(icon,
                  color: Colors.white,
                ),
              )
          ),
        ),
      ),
    );
  }
}
