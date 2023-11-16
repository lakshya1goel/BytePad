import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future openFile({required String url, String? fileName, File? file}) async{
  if (file == null || !file.existsSync()) {
    print('File does not exist.');
    return;
  }

  print('Path: ${file.path}');
  try {
    // print("fffffffffffffffffffffffffffffffff");
    OpenFile.open(file.path);
    // print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
  } catch (e) {
    print('Error opening file: $e');
  }
}

Future<File?> downloadFile(String url, String name) async{
  try {
    // Get external storage directory
    final externalStorage = await getExternalStorageDirectory();

    // Ensure that the external storage directory is available
    if (externalStorage == null) {
      throw Exception("External storage directory not available");
    }

    // Create a File in the external storage directory
    final file = File('${externalStorage.path}/$name');

    // Download the file using Dio
    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    // Open the file and write the downloaded data
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();

    return file;
  } catch (e) {
    print("Error downloading file: $e");
    return null;
  }
}

void downloadAndOpenFile(String fileUrl, String fileName) async {
  // Download the file
  // print("uuuuuuuuuu");
  File? downloadedFile = await downloadFile(fileUrl, fileName);
  // print("lllllllllllllllll");
  // Open the file if it was downloaded successfully
  if (downloadedFile != null) {
    // print("aaaaaaaaaaaaaaaa");
    await openFile(url: fileUrl, fileName: fileName, file: downloadedFile);
    // print("nnnnnnnnnnnnnnnnn");
  } else {
    print('File download failed.');
  }
}