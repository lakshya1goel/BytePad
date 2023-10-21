import 'package:bytepad/Views/Widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override

  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/BytePadLogo.png",
                height: size.width*0.35,
                width: size.width*0.35,
              ),
              Text("Login"),
              Text("Hi! Please sign in to continue."),
              CustomInputField(labelText: "Email"),
              CustomInputField(labelText: "Password"),
              TextButton(
                  onPressed: (){},
                  child: Text("Forgot Password?"),
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: Text("LOG IN"),
              )
            ],
          )
      ),
    );
  }
}
