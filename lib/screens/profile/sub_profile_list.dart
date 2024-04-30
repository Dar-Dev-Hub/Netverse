// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../voucher/common/color_extension.dart';

import 'controllers/fetch_subProfile.dart';
import 'controllers/transactions_points_sub.dart';

class SubprofileList extends StatelessWidget {
  SubProfileController subProfileController = Get.put(SubProfileController());

  SubprofileList({super.key});
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
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
          "All your Sub Profiles",
          style: TextStyle(color: TColor.primaryText, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Obx(
              () {
                if (subProfileController.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  final subProfile =
                      subProfileController.subProfileList.toList();

                  return Column(
                    children: [
                      Text(
                        "Your Total Of Sub Profiles : ${subProfileController.subProfileList.length}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: media.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: subProfile.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = subProfile[index];
                            return GestureDetector(
                              onTap: () {
                                // box.write('event', item);
                                // Get.to(() => EventDetails());
                                subProfileController
                                    .updateSelectedIndex(item['name']);
                                print('Sub Prolfiel Name : ${item['name']}');
                                print('clicked');
                              },
                              child: Container(
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
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sub Profile Name : ${item['name']}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Is Active : ${item['subscription']['is_enabled']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                            "Start Date : ${item['subscription']['start_date']}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        const SizedBox(height: 8),
                                        Text(
                                            "End Date : ${item['subscription']['end_date']}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    )),
                                    // Container(
                                    //   width: 100,
                                    //   height: 100,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.grey,
                                    //     borderRadius:
                                    //         BorderRadius.circular(8.0),
                                    //     image: item['imageUrl'] != null
                                    //         ? DecorationImage(
                                    //             fit: BoxFit.cover,
                                    //             image: NetworkImage(
                                    //                 item['imageUrl']),
                                    //           )
                                    //         : DecorationImage(
                                    //             fit: BoxFit.cover,
                                    //             image: NetworkImage(
                                    //                 'https://img.freepik.com/free-vector/gray-label-white-background_1035-4810.jpg'),
                                    //           ),
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'balance : ${item['wallet']['balance']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Set the text of textFieldController2 to the subProfile code
                                              subProfileController
                                                  .updateSelectedIndex(
                                                      item['name']);

                                              print('clicked');
                                              // show alert
                                              _showAlert(context, item['user']);
                                            },
                                            icon: SvgPicture.asset(
                                              "assets/Icons/send_v.svg",
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            item['subscription']
                                                        ['is_enabled'] ==
                                                    true
                                                ? "assets/Icons/status_connected.svg"
                                                : "assets/Icons/status_disconnected.svg",
                                            width: 20,
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 20,
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
    );
    //     ],
    //   ),
    // );
  }
}

void _showAlert(BuildContext context, String subOwner) {
  TextEditingController textFieldController1 = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Send Points from the Sub Profile to your Profile"),
        content: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: textFieldController1,
                  decoration: new InputDecoration(
                    labelText: "How Much Points ? ",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.number,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // You can access the values entered in the text fields
              print("amount : ${textFieldController1.text}");
              print("Owner : $subOwner");

              // You can perform further actions with the entered values
              subTrans({textFieldController1.text}, subOwner);
              Navigator.of(context).pop(); // Close the alert
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
