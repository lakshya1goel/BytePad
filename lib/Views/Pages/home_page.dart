import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:flutter/material.dart';

import '../../Services/storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text("Success!"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // secureStorage.deleteSecureData('email');
            Navigator.pushReplacement(
                context, MaterialPageRoute(
                builder: (context) => LoginPage()));
          }
      ),
    );
  }
}
