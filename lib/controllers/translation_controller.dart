import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TranslationController extends GetxController {
  final _selectedLocale = RxString('en');

  String get selectedLocale => _selectedLocale.value;

  @override
  void onInit() {
    super.onInit();
    _loadSelectedLocale(); // Load saved locale when the controller initializes
  }

  void _loadSelectedLocale() async {
    final box = GetStorage();
    if (box.hasData('selectedLocale')) {
      _selectedLocale.value = box.read('selectedLocale');
    }
  }

  void changeLocale(String locale) {
    _selectedLocale.value = locale;
    Get.updateLocale(Locale(locale));
    final box = GetStorage();
    box.write('selectedLocale', locale); // Save selected locale to storage
  }
}
