import 'package:flutter/material.dart';

import '../../../Utils/Constants/colors.dart';

class PaperSolutionDisplay extends StatefulWidget {
  final int? paperId;
  const PaperSolutionDisplay({required this.paperId, Key? key}) : super(key: key);

  @override
  State<PaperSolutionDisplay> createState() => _PaperSolutionDisplayState();
}

class _PaperSolutionDisplayState extends State<PaperSolutionDisplay> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,
              size: size.width*0.1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                child: Text('Past Exams',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
