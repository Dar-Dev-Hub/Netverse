// TODO Implement this library.import 'dart:io';

// ignore_for_file: unused_import

import 'dart:io';

import 'package:unity_ads_plugin/unity_ads_plugin.dart';

// AppOpenAd? openAd;

// Future<void> loadAd() async {
//   List<String> testDeviceIds = ['802EB7B521BF0C6C2B3A59BC647F3650'];

//   // Set request configuration with test device IDs
//   RequestConfiguration requestConfiguration = RequestConfiguration(
//     tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
//     testDeviceIds: testDeviceIds,
//   );

//   await MobileAds.instance.updateRequestConfiguration(requestConfiguration);

//   await AppOpenAd.load(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-6795121362532213/9468921246'
//           : 'ca-app-pub-3940256099942544/5135589807',
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
//         print('ad is loaded');
//         openAd = ad;
//         openAd!.show();
//       }, onAdFailedToLoad: (error) {
//         print('ad failed to load $error');
//       }),
//       orientation: AppOpenAd.orientationPortrait);
// }

// Future<void> showAd() async {
//   print(
//       'aaaa1111111111111111aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
//   await UnityAds.load(
//     placementId: 'Rewarded_Android',
//     onComplete: (placementId) => print('Load Complete $placementId'),
//     onFailed: (placementId, error, message) =>
//         print('Load Failed $placementId: $error $message'),
//   );
//   await UnityAds.showVideoAd(placementId: 'Rewarded_Android');
//   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
// }
