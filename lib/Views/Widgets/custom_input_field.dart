import 'package:flutter/material.dart';
import '../../theme_data.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  const CustomInputField({ required this.labelText, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: inputFieldColor,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
