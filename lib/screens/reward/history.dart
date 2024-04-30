import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfiniteNumbersController extends GetxController {
  RxList<int> numbers = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Generate an array of infinite numbers
    // for (int i = 0; i < 1000; i++) {
    //   numbers.add(i);
    // }
  }
}

class InfiniteNumbersWidget extends StatelessWidget {
  final InfiniteNumbersController controller =
      Get.put(InfiniteNumbersController());

  InfiniteNumbersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your History'),
      ),
      body: const Center(
        child: Text(
          'Coming soon...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}


//  Obx(
//         () => 
//         ListView.builder(
//           itemCount: controller.numbers.length,
//           itemBuilder: (context, index) {
//             // Calculate the date for the current index
//             DateTime date = DateTime.now().add(Duration(days: index));

//             // Calculate the number for the current index
//             int number = controller.numbers[index];

//             // Calculate some other information for the current index
//             String otherInfo = 'Other Information for $number';

//             // Return a ListTile widget with the date, number, and other information
//             return ListTile(
//               title: Text('Date: ${date.toString()}'),
//               subtitle: Text('Number: $number\n$otherInfo'),
//             );
//           },
//         ),
//       ),