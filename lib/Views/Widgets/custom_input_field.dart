import 'package:flutter/material.dart';
import '../../theme_data.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  const CustomInputField({ required this.labelText, required this.icon, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: TextFormField(
          cursorColor: blueColor,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: labelColor
            ),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            prefixIcon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: blueColor,
                ),
                child: Icon(icon,
                  color: Colors.white,
                )
            ),
          ),
        ),
      ),
    );
  }
}
