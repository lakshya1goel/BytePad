import 'dart:io';
import 'dart:math';

import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentSelectionScren extends StatefulWidget {
  const DocumentSelectionScren({super.key});

  @override
  State<DocumentSelectionScren> createState() => _DocumentSelectionScrenState();
}

class _DocumentSelectionScrenState extends State<DocumentSelectionScren> {

  bool isLoading = false;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  File? fileToDisplay;

  Future<void> requestPermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      print(status);
    } else if (status.isDenied) {
      Permission.storage.request();
      openAppSettings();
    }
  }


  void pickFile() async {
    try{
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'ppt', 'jpeg', 'png', 'word'],
      );

      if(result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.name.toString());

        print('filename: $_fileName');
        setState(() {

        });
      }

      setState(() {
        isLoading = false;
      });
    }
    catch(e) {
      print(e);
    }
  }

  void loadSelectedFiles(PlatformFile file) {

  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07, vertical: size.height*0.02),
                child: Text('Upload',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                      child: DropdownButton(
                        hint: Text('Code'),
                        // value: selectedValue,
                        items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){},
                            // (String newValue) {
                          // setState(() {
                          //   selectedValue = newValue;
                          // });
                        // },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                      child: DropdownButton(
                        hint: Text('Year'),
                        // value: selectedValue,
                        items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){},
                        // (String newValue) {
                        // setState(() {
                        //   selectedValue = newValue;
                        // });
                        // },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                      child: DropdownButton(
                        hint: Text('Semester'),
                        // value: selectedValue,
                        items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){},
                        // (String newValue) {
                        // setState(() {
                        //   selectedValue = newValue;
                        // });
                        // },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                      child: DropdownButton(
                        hint: Text('Type'),
                        // value: selectedValue,
                        items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){},
                        // (String newValue) {
                        // setState(() {
                        //   selectedValue = newValue;
                        // });
                        // },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.03,),
              (pickedFile == null) ? Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                child: DottedBorder(
                  color: Colors.grey,
                  dashPattern: [8, 4],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  child: Container(
                    height: size.height*0.4,
                    width: size.width*0.85,
                    child: Column(
                      children: [
                        SizedBox(height: size.height*0.1,),
                        Image.asset('assets/images/UploadIcon.png',
                          width: size.width*0.15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: (){
                                  pickFile();
                                },
                                child: Text('Upload',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    fontSize: size.width*0.05,
                                      color: blueColor),
                                )
                            ),
                            Text('your file here',
                              style: TextStyle(
                                  fontSize: size.width*0.05,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.065),
                          child: Column(
                            children: [
                              Text('Supported formats:',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text('JPEG, PNG, PDF, Word, PPT',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.08, vertical: size.height*0.025),
                    child: Text("Loaded - 1 file",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF676767),
                        fontSize: size.width*0.05
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF11AF22),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(_fileName!),
                            SizedBox(width: size.width*0.13,),
                            IconButton(
                              onPressed: (){},
                                icon: Icon(Icons.repeat),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.25,)
                ],
              ),
              SizedBox(height: size.height*0.03,),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: size.width*0.85,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: isLoading ?
                          SizedBox(
                            width: size.width*0.052,
                            height: size.height*0.028,
                            child: CircularProgressIndicator(),
                          )
                              : Text("UPLOAD",
                            style: TextStyle(
                              fontSize: size.width*0.05,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(blueColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // (pickedFile == null) ? Container(): Image.file(File(pickedFile!.path.toString()))
            ],
          ),
        ),
      ),
    );
  }
}
