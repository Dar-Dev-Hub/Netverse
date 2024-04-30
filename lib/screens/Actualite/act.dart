// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:alphanetverse/screens/Actualite/textWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/feed_controller.dart';
import 'details_act.dart';

class Act extends StatelessWidget {
  final FeedController feedController = Get.put(FeedController());
  final box = GetStorage();

  Act({super.key});

  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Obx(
              () {
                if (feedController.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  final articleFeeds = feedController.feedList.reversed
                      .where((feed) => feed['feed_type'] == 'Article')
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: articleFeeds.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = articleFeeds[index];
                      print(item);
                      return GestureDetector(
                        onTap: () {
                          box.write('article', item);

                          Get.to(() => ArticleDetails());
                        },
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('assets/img/logo.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text('NetVerse'),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      item['image'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyTextWidget(
                                      initialText: item['content'],
                                      maxLines: 6,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        box.write('article', item);
                                        Get.to(() => ArticleDetails());
                                      },
                                      child: Text('View More'),
                                    ),
                                  ],
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
      ),
    );
  }
}
