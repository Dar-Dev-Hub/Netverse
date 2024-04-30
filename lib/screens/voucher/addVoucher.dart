// ignore_for_file: must_be_immutable

import 'package:alphanetverse/common_widgets/snack_message/snack_message.dart';
import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
import 'package:alphanetverse/screens/voucher/controllers/fetch.dart';
import 'package:alphanetverse/screens/voucher/controllers/qr_code_widget.dart';
import 'package:alphanetverse/screens/voucher/controllers/voucher_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../reward/reward.dart';
import 'common/color_extension.dart';
import 'common_widget/round_textfield.dart';

class AddGiftCardView extends StatelessWidget {
  VoucherController voucherController = Get.put(VoucherController());

  final box = GetStorage();
  RxString result = ''.obs;
  TextEditingController codeController = TextEditingController();

  RxBool showQRCode = false.obs;

  AddGiftCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var scannedQR = ''.obs;

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
          "Add Voucher Card",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Enter or scan the voucher code to add it to your account.",
                textAlign: TextAlign.left,
                style: TextStyle(color: TColor.secondaryText, fontSize: 14),
              ),
            ),
            SizedBox(height: height * 0.05),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: TColor.white,
                borderRadius: BorderRadius.circular(3),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  Text(
                    "Voucher Card",
                    style: TextStyle(color: TColor.secondaryText, fontSize: 16),
                  ),
                  SizedBox(height: height * 0.02),
                  Obx(() => Text(
                        '${result.value.obs}',
                        style:
                            TextStyle(color: TColor.primaryText, fontSize: 13),
                      )),
                  SizedBox(height: height * 0.02),
                  Obx(() => showQRCode.value
                      ? SizedBox(
                          height: 100,
                          width: 100,
                          child: QRCodeWidget(data: result.value),
                        )
                      : Container()),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: 280,
                    height: 20,
                    color: TColor.secondaryText.withOpacity(0.2),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  RoundTextField(
                    controller: codeController,
                    title: "Voucher Code",
                    hitText: "Enter Voucher Code",
                  ),
                  const SizedBox(height: 8),
                  RoundButton(
                    colors: const Color.fromARGB(218, 172, 126, 0),
                    title: "Scan Voucher card",
                    type: RoundButtonType.textPrimary,
                    onPressed: () async {
                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ),
                      );
                      box.write('Vouchercode', res);
                      scannedQR.value = box.read('Vouchercode');
                      result.value = scannedQR.value;
                      codeController.text = result.value;

                      showQRCode.value = true;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: CustomSnackBarContent(
                            title: 'Success',
                            message: 'Your Voucher has been scanned.',
                            bgcolor: Colors.green,
                            bubcolor: Color.fromARGB(255, 0, 114, 4),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: TColor.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: RoundButton(
          colors: const Color.fromARGB(218, 172, 126, 0),
          title: "Apply",
          onPressed: () async {
            print('Before await apply voucher');
            await toOwned(codeController.text);
            Get.back();
          },
          type: RoundButtonType.textPrimary,
        ),
      ),
    );
  }
}
