// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Sos extends StatefulWidget {
  const Sos({super.key});

  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameControler = TextEditingController();
  final TextEditingController messgecontroller = TextEditingController();
  bool enable = false, fname = false, lname = false, Smessage = false;

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      const String scriptURL =
          'https://script.google.com/macros/s/AKfycbwYo_vCqE8RDpEj6rfTefsuPsiv24aM7OVnbCql6wUJ0ihdNN5q7GTab6TYWhZVvhX3/exec';

      String firstname = firstnameController.text;
      String lastname = lastnameControler.text;
      String messge = messgecontroller.text;

      String queryString =
          "?firstname=$firstname&lastname=$lastname&messge=$messge";

      var finalURI = Uri.parse(scriptURL + queryString);
      try {
        var response = await http.get(finalURI);
        if (response.statusCode == 200) {
          var bodyR = convert.jsonDecode(response.body);
          print(bodyR);
        } else {
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending request: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child:
                // SvgPicture.network(
                //   'https://alphanetverse.com/wp-content/uploads/2022/07/alphanetverse-LOGO.svg',
                //   color: Colors.red,
                //   width: 200,
                //   height: 120,
                //   alignment: Alignment.topCenter,
                // ),
                SvgPicture.asset(
              'assets/img/trace.svg',
              width: 200,
              height: 180,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Enter your first Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  enableInteractiveSelection: true,
                  controller: firstnameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 68, 67, 67)),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "first name",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  onChanged: (val) {
                    setState(() {
                      if (val.trim().isNotEmpty) {
                        fname = true;
                      } else {
                        fname = false;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Enter your Last Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  enableInteractiveSelection: true,
                  controller: lastnameControler,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 68, 67, 67)),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  onChanged: (val) {
                    setState(() {
                      if (val.trim().isNotEmpty) {
                        lname = true;
                      } else {
                        lname = false;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "How Did You Hear About Us :",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextFormField(
                  controller: messgecontroller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Message',
                  ),
                  onChanged: (val) {
                    setState(() {
                      if (val.trim().isNotEmpty) {
                        Smessage = true;
                      } else {
                        Smessage = false;
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: const Color(0xFF0DF69E),
                  ),
                  onPressed: () async {
                    var whatsappUrl = Uri.parse(
                        "whatsapp://send?phone=${"+216" "56565030"}"
                        "&text=${Uri.encodeComponent("userName: ${firstnameController.text} \n LastName: ${firstnameController.text} \n"
                            "Meassage: ${messgecontroller.text}")}");
                    try {
                      launchUrl(whatsappUrl);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10),
                    child: Text(
                      "Send Message Direct On whatsapp",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 60.0),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(50),
          //       ),
          //       backgroundColor: const Color(0xFF0DF69E),
          //     ),
          //     onPressed: _submitForm,
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          //       child: Text(
          //         "contact us on google",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Color.fromARGB(255, 255, 255, 255),
          //           //fontWeight: FontWeight.bold,
          //           fontSize: 10,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ]),
      ),
    );
  }
}
