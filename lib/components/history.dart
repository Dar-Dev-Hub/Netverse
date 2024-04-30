import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/history/api_history.dart';

class HistoryPage extends StatelessWidget {
  // Sample data for historical events
  final box = GetStorage();
  final List<HistoricalEvent> historicalEvents = [
    HistoricalEvent(
      title: 'Event 1',
      date: 'January 1, 2023',
      description: 'Description for event 1.',
    ),
    HistoricalEvent(
      title: 'Event 2',
      date: 'February 15, 2023',
      description: 'Description for event 2.',
    ),
    // Add more historical events as needed
  ];

  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HistoryApi());
    Get.find<HistoryApi>().historyApi();
    final data = box.read('historyData');
    print(data);
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: ListView.builder(
        itemCount: historicalEvents.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(historicalEvents[index].title),
              subtitle: Text(historicalEvents[index].date),
              onTap: () {
                // Handle tapping on a historical event
                // You can navigate to a detailed page or show more information
              },
            ),
          );
        },
      ),
      bottomSheet: Obx(() => data.isEmpty
          ? const Text('No data available')
          : Text(data['start_of_week'])),
    );
  }
}

class HistoricalEvent {
  final String title;
  final String date;
  final String description;

  HistoricalEvent(
      {required this.title, required this.date, required this.description});
}
