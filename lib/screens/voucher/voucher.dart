// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:alphanetverse/screens/voucher/addVoucher.dart';
import 'package:alphanetverse/screens/voucher/controllers/fetch.dart';
import 'package:alphanetverse/screens/voucher/voucherList.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sensitive_clipboard/sensitive_clipboard.dart';

import 'common/color_extension.dart';
import 'common_widget/gift_row.dart';
import 'common_widget/round_buttom.dart';
import 'controllers/voucher_api.dart';

class Voucher_screen extends StatefulWidget {
  const Voucher_screen({super.key});
  static const routeName = '/addvoucher';

  @override
  State<Voucher_screen> createState() => _Voucher_screenState();
}

class _Voucher_screenState extends State<Voucher_screen> {
  bool isLoading = false;
  final box = GetStorage();
  VoucherController voucherController = Get.put(VoucherController());
  var code;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: TColor.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/img/gifts1.png",
                width: media.width * 0.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                child: Column(children: [
                  Text(
                    "You have no card yet",
                    style: TextStyle(color: TColor.primaryText, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "You currently have no cards linked to you account. Get started by see redeeming or buying one now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.secondaryText, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      colors: const Color.fromARGB(218, 172, 126, 0),
                      title: "Add voucher",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddGiftCardView(),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundButton(
                      colors: const Color.fromARGB(218, 172, 126, 0),
                      title: "Buy voucher",
                      type: RoundButtonType.textPrimary,
                      onPressed: () {
                        _showAlertDialog(context);
                      })
                ]),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          voucherController.fetchVoucher();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VoucherList(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                              color: TColor.white,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/contactless-card.png",
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Voucher List",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 14),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                              color: TColor.white,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/present.png",
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Gift voucher",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColor.secondaryText,
                                      fontSize: 14),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need help with these options?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: TColor.secondaryText, fontSize: 14),
                    ),
                    GiftRow(
                      title: "What is a Gift Card?",
                      onPressed: () {},
                    ),
                    GiftRow(
                      title: "What is a Gift Voucher?",
                      onPressed: () {},
                    ),
                    GiftRow(
                      title: "Gift card/ Voucher FAQs",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _showAlertDialog(BuildContext context) async {
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
              'Are you sure you want to buy this voucher?',
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
                  try {
                    await voucherPurchased();
                    code = box.read('voucherCode');
                    Navigator.of(context).pop(); // Close the first dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Voucher Created'),
                          content: SizedBox(
                            height: 105,
                            child: Column(
                              children: [
                                BarcodeWidget(
                                  barcode: Barcode
                                      .qrCode(), // Barcode type and settings
                                  data: '$code', // Content
                                  width: 80,
                                  height: 80,
                                ),
                                Text("$code"),
                              ],
                            ),
                          ),
                          actions: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("Copy code",
                                                style: TextStyle(
                                                    color: TColor.secondaryText,
                                                    fontSize: 12)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: IconButton(
                                                onPressed: () {
                                                  SensitiveClipboard.copy(
                                                      '${code}');
                                                  final snackBar = SnackBar(
                                                    duration:
                                                        Duration(seconds: 1),
                                                    content:
                                                        Text('Copied: ${code}'),
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
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } catch (error) {
                    print('Error purchasing voucher: $error');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content:
                            Text('Error purchasing voucher. Please try again.'),
                      ),
                    );
                  }
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
}
