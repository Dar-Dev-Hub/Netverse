// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/feed_controller.dart';
import 'details_events.dart';

class Events extends StatelessWidget {
  final FeedController feedController = Get.put(FeedController());
  final box = GetStorage();
  final ScrollController _scrollController = ScrollController();

  Events({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Obx(
            () {
              if (feedController.isLoading.value) {
                return CircularProgressIndicator();
              } else {
                final eventFeeds = feedController.feedList.reversed
                    .where((feed) => feed['feed_type'] == 'Event')
                    .toList();

                return ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: eventFeeds.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = eventFeeds[index];
                    return GestureDetector(
                      onTap: () {
                        box.write('event', item);
                        Get.to(() => EventDetails());
                      },
                      child: Container(
                        height: 136,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )),
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                  imageUrl: item['image'] ??
                                      'https://img.freepik.com/free-vector/gray-label-white-background_1035-4810.jpg',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
