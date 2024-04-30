import 'dart:io';
import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/document_verification/image_submission.dart';
import '../../voucher/common/color_extension.dart';

class DocumentVerifScreen extends StatefulWidget {
  const DocumentVerifScreen({super.key});

  @override
  _DocumentVerifScreenState createState() => _DocumentVerifScreenState();
}

class _DocumentVerifScreenState extends State<DocumentVerifScreen> {
  final List<File> _imageFiles = [];
  String? _selectedDocumentType;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        if (_imageFiles.length < 3) {
          _imageFiles.add(File(image.path));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 20,
            height: 20,
            color: TColor.secondaryText,
          ),
        ),
        title: Text(
          "Document Verification",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              const Text(
                'Choose Document Type:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 36.0,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    hint: const Text(
                      'Select Document Type',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    value: _selectedDocumentType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDocumentType = newValue;
                      });
                    },
                    items: <String>['CIN', 'Passport', 'Driver License']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Choose Document Images:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  for (int i = 0; i < _imageFiles.length; i++)
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.file(
                            _imageFiles[i],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _imageFiles.removeAt(i);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (_imageFiles.length < 3)
                    InkWell(
                      onTap: () {
                        _takePicture();
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: TColor.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: RoundButton(
          colors: const Color.fromARGB(218, 0, 152, 172),
          title: "Submit",
          onPressed: () {
            submitImages(_imageFiles, context);
          },
          type: RoundButtonType.textPrimary,
        ),
      ),
    );
  }
}
