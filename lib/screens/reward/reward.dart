import 'dart:async';
import 'package:alphanetverse/controllers/reward_controller.dart';
import 'package:alphanetverse/screens/profile/controllers/fetch_subProfile.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/wallet/wallet_api.dart';
import '../../common_widgets/snack_message/snack_message.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/wallet_controller.dart';
import '../../services/Ads/unityAds.dart';
import '../voucher/addVoucher.dart';
import '../voucher/common/color_extension.dart';
import '../voucher/common_widget/gift_row.dart';
import '../voucher/common_widget/round_buttom.dart';

import '../voucher/controllers/voucher_api.dart';
import 'functions/history_api.dart';
import 'history.dart';

class Reward_page extends StatefulWidget {
  const Reward_page({super.key});

  @override
  State<Reward_page> createState() => _Reward_pageState();
}

class _Reward_pageState extends State<Reward_page> {
  Timer? _refreshTimer;
  bool _isFirstLoad = true;

  final box = GetStorage();
  final walletController =
      Get.put(WalletController()); // Initialize the controller
  final subProfileController = Get.put(SubProfileController());
  final rewardController = Get.put(RewardController());
  final walletData = Get.put(WalletData());

  int countdown = 10;

  final String lastResetKey = 'lastReset';

  List<int> dailyPoints = [0, 0, 0, 0, 0, 0, 0];

  Future<void> fetchPoints() async {
    await currentVoucher();
    print(await currentVoucherEnabled());
    await fetchMainBalance();
    await fetchSubAccountBalance();
    rewardController.updateRewardAmount();
    await rewardController.rewardsMainController();
    await rewardController
        .rewardsSubController(box.read('selectedSubProfileName'));
  }

  getBalance(String subProfileName) {
    if (subProfileName == 'Main Profile') {
      return box.read('mainBalancePoints') ?? "0";
    } else {
      return box.read('selectedSubProfileBalance') ?? "0";
    }
  }

  getRewardAmount() {
    final selectedSubProfileName = box.read('selectedSubProfileName') ?? '';
    final rewards = selectedSubProfileName == 'Main Profile'
        ? box.read('rewards')
        : box.read('rewardsSub');
    return rewards?.toString() ?? '0';
  }

  void _showAlertDialog(token) async {
    final AuthController authController = Get.find();
    print(authController.user);
    dynamic isSubscriptionActive = await currentVoucherEnabled();
    print(isSubscriptionActive == 'true');

    // final String token = box.read('accessToken');

    if (isSubscriptionActive == 'true') {
      // && name == ''
      await AdManager.showRewardedAd();

      try {
        print(box.read('selectedSubProfileName'));
        if (box.read('selectedSubProfileName') == 'Main Profile') {
          print('Inside the first IF${box.read('selectedSubProfileName')}');
          final response = await walletData.fetchWalletWatchAd();
          if (response.statusCode == 202) {
            await fetchPoints();
          } else if (response.statusCode == 403) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: CustomSnackBarContent(
                  title: 'Failed to watch ad',
                  message: 'You have reached your daily limit',
                  bgcolor: Colors.red,
                  bubcolor: Color.fromARGB(255, 131, 35, 28),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          }
        } else {
          final responseSub = await walletController.watchWithSub();
          print(responseSub.statusCode);
          if (responseSub.statusCode == 200) {
            await fetchPoints();
          } else if (responseSub.statusCode == 403) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: CustomSnackBarContent(
                  title: 'Failed to watch ad',
                  message: 'You have reached your daily limit',
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
      } catch (e) {
        print('Errora: $e');
      }
    } else {
      Get.defaultDialog(
        title: 'Do you want to enter your code voucher',
        titleStyle: const TextStyle(fontSize: 20),
        content: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
              "PS: You can still watch ads if you don't have a voucher code"),
        ),
        confirm: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                Get.to(AddGiftCardView());
              },
              child: const Text('Yes'),
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () async {
                // isCounting ? null : startCountdown();
                await AdManager.showRewardedAd();
                Get.back();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  //Function that check and fetches the main profile
  checkProfile() {
    if (box.read('selectedSubProfileName') == 'Main Profile') {
      fetchMainBalance();
    } else {
      fetchSubAccountBalance();
    }
  }

  @override
  void initState() {
    super.initState();
    _startRefreshTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        fetchPoints();
        getBalance(box.read('selectedSubProfileName') ?? 'Main Profile');
      });
      await AdManager.loadUnityIntAd();
      await AdManager.loadUnityRewardedAd();
    });
    var selectedMainProfile = ''.obs;
    subProfileController.fetchSubProfile(selectedMainProfile.value);
    print(
        "the selectedSubProfileName is : ${box.read('selectedSubProfileName')}");

    if (box.read('selectedSubProfileName') == null) {
      box.write('selectedSubProfileName', 'Main Profile');
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startRefreshTimer() {
    if (_isFirstLoad) {
      _refreshTimer = Timer(Duration(seconds: 3), () {
        setState(() {
          print('Page is being refreshed after 3 seconds');
        });
      });
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    rewardController.rewardAmount.value;
    String token = box.read('accessToken');
    var media = MediaQuery.sizeOf(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final subProfile = getBalance(box.read('selectedSubProfileName') ??
        'Main Profile'); // Zid tabdila hna bech to7out select profile
    return WillPopScope(
      onWillPop: () async {
        if (false) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "You are currently interacting as",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(31, 197, 150, 150),
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ],
                          border: Border.all(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              box.read('selectedSubProfileName') ??
                                  'Select a profile',
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        var selectedMainProfile = ''.obs;
                        subProfileController.updateSelectedIndex('mainProfile');
                        subProfileController
                            .fetchSubProfile(selectedMainProfile.value);

                        // display a  selector of names from the list box.read('subProfileNameList') that we saved in getxstorage without using Get.defaultDialog
                        Get.bottomSheet(
                          Container(
                            height: height * 0.3,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, -2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Select a profile',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        box.read('subProfileNameList').length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          box
                                              .read('subProfileNameList')[index]
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onTap: () async {
                                          print(box
                                              .read('subProfileNameList')[index]
                                              .toString());
                                          box.write(
                                              'selectedSubProfileName',
                                              box.read(
                                                  'subProfileNameList')[index]);

                                          await fetchSubAccountBalance();
                                          setState(() {});

                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // refresh page button to update all the page data
                    IconButton(
                      onPressed: () async {
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
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
                                const Icon(Icons.wallet_giftcard_rounded),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Points:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColor.primaryText, fontSize: 17),
                                ),
                                // Obx(() => Text(
                                //       "${walletController.points}",
                                //       textAlign: TextAlign.center,
                                //       style: TextStyle(
                                //           color: TColor.primaryText,
                                //           fontSize: 16),
                                //     )),

                                Text(
                                  "${subProfile.toString()}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColor.primaryText, fontSize: 16),
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
                                const Icon(Icons.replay_rounded),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Daily rewards:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: TColor.primaryText, fontSize: 17),
                                ),
                                Text(
                                  getRewardAmount(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
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
                    "Get your rewards",
                    style: TextStyle(color: TColor.primaryText, fontSize: 20),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Image.asset(
                    "assets/img/rewadrs1.png",
                    width: media.width * 0.3,
                  ),
                  Text(
                    "Your daily rewards is ${getRewardAmount()} per day. \nEarning Points Made Easy",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.secondaryText, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                      colors: const Color.fromARGB(218, 172, 126, 0),
                      title: "WATCH AD",
                      onPressed: () async {
                        if (box.read('selectedSubProfileName') ==
                                'Main Profile' ||
                            box.read('selectedSubProfileName') == null) {
                          // await AdManager.showRewardedAd();
                          _showAlertDialog(token);
                          await fetchPoints();
                        } else {
                          // await walletController.watchWithSub();
                          _showAlertDialog(token);
                          await fetchPoints();
                        }
                        // _showAlertDialog();
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundButton(
                    onPressed: () async {
                      _showAlertDialog(token);

                      //await AdManager.showRewardedAd();
                    },
                    title: "LOCAL AD",
                    colors: const Color.fromARGB(237, 2, 161, 201),
                  )
                ]),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 25),
                  child: GiftRow(
                    title: "Your History",
                    onPressed: () async {
                      HistoryController().historyController();
                      Get.to(InfiniteNumbersWidget());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
