import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class QRCodeWidget extends StatelessWidget {
  final String data;

  const QRCodeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: BarcodeWidget(
        barcode: Barcode.qrCode(),
        data: data,
        width: 200,
        height: 200,
      ),
    );
  }
}
