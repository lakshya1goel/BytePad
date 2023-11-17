import 'dart:io';
import 'package:bytepad/Views/Pages/DocumentUploadingScreens/success_upload_document.dart';
import 'package:bytepad/Services/UploadDocuments/upload_papers.dart';
import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Services/authentication/storage.dart';

String? accessToken;
class DocumentSelectionScreen extends StatefulWidget {
  const DocumentSelectionScreen({super.key});

  @override
  State<DocumentSelectionScreen> createState() => _DocumentSelectionScreenState();
}

class _DocumentSelectionScreenState extends State<DocumentSelectionScreen> {

  bool isApiLoading = false;
  bool isLoading = false;
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  File? fileToDisplay;
  String? paperTitle;
  String? paperYear;
  String? sem;
  String? code;
  String? path;
  String? name;
  String? type;
  String? filePath;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      setState(() {
        accessToken = value;
      });
      print('Access Token: $accessToken');
    });
  }

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
        filePath = pickedFile!.path;

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
                        value: code,
                        items: <String>['BAS103', 'BAS101', 'BEE101', 'BCS101', 'BAS104', 'BAS151', 'BEE151', 'BCS151', 'BCE151', 'BAS203']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){
                          setState(() {
                            code = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: size.width*0.38,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                      child: DropdownButton(
                        hint: Text('Year       '),
                        value: paperYear,
                        items: <String>['2015', '2016', '2017', '2018', '2019', '2020', '2021', '2022']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){
                        setState(() {
                          paperYear = newValue;
                        });
                        },
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
                        value: sem,
                        items: <String>['1', '2', '3', '4', '5', '6', '7', '8']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){
                        setState(() {
                          sem = newValue;
                        });
                        },
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
                        value: type,
                        items: <String>['ST1', 'ST2', 'PUT', 'UT', 'Retest(s)']
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue){
                        setState(() {
                          type = newValue;
                        });
                        },
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_fileName!,
                              style: TextStyle(fontSize: size.width*0.032),
                            ),
                            IconButton(
                              onPressed: (){
                                pickFile();
                              },
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
                        onPressed: () async {
                          if (pickedFile != null) {
                            paperTitle = "$type $code $paperYear";
                            setState(() {
                              isApiLoading = true; // Set isApiLoading for the API call
                            });

                            await postPapers(
                              accessToken,
                              paperTitle.toString(),
                              paperYear.toString(),
                              sem.toString(),
                              code.toString(),
                              filePath.toString(),
                              _fileName!,
                            );

                            setState(() {
                              isApiLoading = false; // Reset isApiLoading after the API call
                            });

                            // Only navigate if the API call was successful
                            if (!isApiLoading) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SuccessUploadScreen(),
                                ),
                              );
                            }
                          }
                        },
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
            ],
          ),
        ),
      ),
    );
  }
}
