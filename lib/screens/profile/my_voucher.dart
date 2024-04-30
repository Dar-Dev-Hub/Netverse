import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../voucher/common/color_extension.dart';
import '../voucher/controllers/fetch.dart';

class MyVoucher extends StatelessWidget {
  MyVoucher({Key? key}) : super(key: key);
  VoucherController voucherController = Get.put(VoucherController());

  @override
  Widget build(BuildContext context) {
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
          "My Vouchers",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: Padding(
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
                            return Container(
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
                                ],
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
    );
  }
}
