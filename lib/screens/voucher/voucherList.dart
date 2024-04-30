// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:sensitive_clipboard/sensitive_clipboard.dart';

import '../../common_widgets/snack_message/snack_message.dart';
import 'common/color_extension.dart';

import 'controllers/fetch.dart';
import 'controllers/voucher_api.dart';

// ignore: must_be_immutable
class VoucherList extends StatelessWidget {
  VoucherController voucherController = Get.put(VoucherController());
  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();

  VoucherList({super.key});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: TColor.white,
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
          "All your vouchers",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Obx(
                () {
                  if (voucherController.isLoading.value) {
                    return CircularProgressIndicator();
                  } else {
                    final voucher = voucherController.voucherList.toList();

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Enter the long number and scratch off the panel on your card to reveal your pin as shown below.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: TColor.secondaryText, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: BarcodeWidget(
                            barcode:
                                Barcode.qrCode(), // Barcode type and settings
                            data: voucherController.selectedVoucherIndex == -1
                                ? ""
                                : "${voucherController.selectedVoucherIndex}", // Content
                            width: 200,
                            height: 200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Click To copy code",
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: IconButton(
                                  onPressed: () {
                                    SensitiveClipboard.copy(
                                        '${voucherController.selectedVoucherIndex}');
                                    final snackBar = SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          'Copied: ${voucherController.selectedVoucherIndex}'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  icon: Icon(Icons.copy),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Divider(
                            color: Color.fromARGB(255, 5, 109, 109),
                          ),
                        ),
                        Text(
                          "Your Total vouchers is : ${voucherController.voucherList.length}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: voucher.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = voucher[index];

                              return GestureDetector(
                                onTap: () async {
                                  // box.write('event', item);
                                  // Get.to(() => EventDetails());
                                  voucherController
                                      .updateSelectedIndex(item['code']);
                                  print('clicked');
                                  if (item['is_enabled'] == false) {
                                    _showAlertDialog(context, index);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: CustomSnackBarContent(
                                          title: 'Active',
                                          message:
                                              'This voucher is already active',
                                          bgcolor: Colors.green,
                                          bubcolor:
                                              Color.fromARGB(255, 0, 114, 4),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 120,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Voucher Code : ${item['code']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Is Active : ${item['is_enabled']}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              item['is_enabled'] == true
                                                  ? "assets/Icons/status_connected.svg"
                                                  : "assets/Icons/status_disconnected.svg",
                                              width: 20,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                // Set the text of textFieldController2 to the voucher code
                                                voucherController
                                                    .updateSelectedIndex(
                                                        item['code']);

                                                print('clicked');
                                                // show alert
                                                _showAlert(
                                                    context, item['code']);
                                              },
                                              icon: SvgPicture.asset(
                                                "assets/Icons/send_v.svg",
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
    //     ],
    //   ),
    // );
  }
}

void _showAlert(BuildContext context, String voucherCode) {
  TextEditingController textFieldController1 = TextEditingController();
  // TextEditingController textFieldController2 = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text("Send voucher code to friend"),
          content: SizedBox(
            height: 160,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: textFieldController1,
                    onChanged: (text) {
                      textFieldController1.text = text.toLowerCase();
                      textFieldController1.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: textFieldController1.text.length),
                      );
                    },
                    decoration: new InputDecoration(
                      labelText: "Enter Email",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Voucher Code : "),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    voucherCode,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // You can access the values entered in the text fields
                print("Email : ${textFieldController1.text}");
                print("Voucher Code : $voucherCode");

                await sendVoucherToFriend(
                    voucherCode, textFieldController1.text);

                // You can perform further actions with the entered values

                Navigator.of(context).pop(); // Close the alert
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    },
  );
}

void _showAlertDialog(BuildContext context, int index) async {
  VoucherController voucherController = Get.put(VoucherController());
  final voucher = voucherController.voucherList.toList();
  final item = voucher[index];

  try {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Confirmation',
            style: TextStyle(color: TColor.primaryText, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure you want to activate this voucher?',
            textAlign: TextAlign.center,
            style: TextStyle(color: TColor.secondaryText, fontSize: 17),
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                  side: BorderSide(color: Colors.green, width: 0.5),
                ),
              ),
              label: Text('YES'),
              icon: Icon(Icons.check),
              onPressed: () async {
                Navigator.of(context).pop();
                print(item['code']);
                await sendVoucherToCurrent(item['code']);
                voucherController.refreshVoucherList();
              },
            ),
            const SizedBox(width: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                backgroundColor: Colors.white,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1)),
                ),
                side: BorderSide(color: Colors.redAccent, width: 0.5),
              ),
              label: Text('NO'),
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
                print('Pressed');
              },
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  } catch (error) {
    print('Error showing AlertDialog: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Error showing AlertDialog. Please try again.'),
      ),
    );
  }
}
