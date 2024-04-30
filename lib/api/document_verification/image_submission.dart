import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../common_widgets/snack_message/snack_message.dart';

Future<void> submitImages(List<File> imageFiles, BuildContext context) async {
  final url =
      Uri.parse('https://api.alphanetverse.com/api/document-verification/');
  final request = http.MultipartRequest('POST', url);
  request.headers['Authorization'] =
      'Bearer ${GetStorage().read('accessToken')}';

  for (int i = 0; i < imageFiles.length; i++) {
    request.files.add(
      await http.MultipartFile.fromPath(
        'document',
        imageFiles[i].path,
      ),
    );
  }

  final response = await request.send();
  final responseData = await response.stream.bytesToString();
  print(responseData);

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: CustomSnackBarContent(
          title: 'Success',
          message: 'Your documents are submitted successfully.',
          bgcolor: Colors.green,
          bubcolor: Color.fromARGB(255, 0, 114, 4),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: CustomSnackBarContent(
          title: 'Error',
          message: 'Something went wrong.',
          bgcolor: Colors.red,
          bubcolor: Color.fromARGB(255, 131, 35, 28),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
