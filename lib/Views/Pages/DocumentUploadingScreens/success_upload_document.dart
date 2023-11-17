import 'package:flutter/material.dart';

import '../Dashboards/hod_dashboard.dart';

class SuccessUploadScreen extends StatelessWidget {
  const SuccessUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    Future<void> navigateToHodDashboard() async {
      await Future.delayed(Duration(seconds: 4));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HodDashboard(),
        ),
      );
    }
    navigateToHodDashboard();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.check_circle_outline,
                color: Color(0xFF4CCD59),
                size: size.width*0.4,
              ),
            ),
            Text("Success!",
              style: TextStyle(
                fontSize: size.width*0.08,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.15, vertical: size.height*0.02),
              child: Text("Congratulations! You just uploaded a document. Please wait till it gets processed.",
                style: TextStyle(
                  fontSize: size.width*0.045
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
