import 'package:alphanetverse/screens/voucher/common_widget/round_buttom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alphanetverse/controllers/auth_controller.dart';
import 'package:alphanetverse/controllers/wallet_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class CreditCardsPage extends StatelessWidget {
  CreditCardsPage({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    walletController.fetchPoints();
    walletController.fetchWithdrawRequests();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            _buildBalanceCard(
              'Balance: ',
              double.parse(walletController.ac_cash.toString()),
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Withdraw Requests:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Expanded(
                    child: Obx(
                      () {
                        final requests = walletController.withdrawalRequests;
                        if (requests.isEmpty) {
                          return Center(
                            child: Text('No requests found!'),
                          );
                        } else {
                          final reversedRequests = List.from(requests.reversed);

                          return ListView.builder(
                            itemCount: reversedRequests.length,
                            itemBuilder: (context, index) {
                              final request = reversedRequests[index];
                              final formattedAmount =
                                  double.parse(request.amount)
                                      .toStringAsFixed(2);

                              return Card(
                                elevation: 2.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  leading: Icon(Icons.money),
                                  title: Text('Amount: ${formattedAmount} AC'),
                                  trailing: Text(
                                    '${request.status}',
                                    style: TextStyle(
                                      color: request.status == 'pending'
                                          ? Colors.orange
                                          : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            RoundButton(
              colors: Color.fromARGB(255, 218, 59, 48),
              title: "Withdraw",
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text('Withdraw'),
                    content: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter amount to withdraw',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        walletController.withdrawAmount = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (walletController.withdrawAmount.isNotEmpty) {
                            walletController.withdraw(
                              walletController.withdrawAmount,
                              context,
                            );
                            Get.back();
                          } else {
                            print('Please enter a valid amount');
                          }
                        },
                        child: Text('Withdraw'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String title, double amount) {
    final acCash = walletController.ac_cash.value;
    final points = walletController.points.value;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            // Text(
            //   'Points:  $points', // Display the points balance
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     color: Colors.blue,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 8.0),
            Text(
              '$acCash AC', // Display the ac_cash balance
              style: TextStyle(
                fontSize: 24.0,
                color: Color.fromARGB(218, 172, 126, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
