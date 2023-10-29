import 'package:flutter/material.dart';
import '../../Contollers/validation.dart';
import '../../theme_data.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? resetPasswordController;
  final GlobalKey<FormState>? formKey;
  const CustomInputField({ required this.labelText, required this.icon, required this.controller, this.emailController, this.passwordController, this.formKey,  this.resetPasswordController, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          cursorColor: blueColor,
          validator: (value) {
            String? emailError = emailController?.text != null
                ? Validator.isValidEmail(emailController!.text)
                : null;

            if (emailError != null) {
              return emailError;
            }

            String? passwordError = passwordController?.text != null
                ? Validator.isValidPassword(passwordController!.text)
                : null;

            if (passwordError != null) {
              return passwordError;
            }

            // String? resetPasswordError = passwordController?.text != null
            //     ? Validator.isResetPassword(passwordController!.text)
            //     : null;
            //
            // if (resetPasswordError != null) {
            //   return resetPasswordError;
            // }

          },
          decoration: InputDecoration(
            hintText: labelText,
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
      ),
    );
  }
}
