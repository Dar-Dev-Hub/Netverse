import 'package:get/get.dart';

import '../api/feeds/get_all_feed.dart';

class FeedController extends GetxController {
  var feedList = <dynamic>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeeds();
    // Uncomment the following line if you want to periodically fetch feeds
    // Timer.periodic(Duration(seconds: 10), (Timer t) {
    //   fetchFeeds();
    // });
  }

  // Function to fetch feeds using FeedService
  void fetchFeeds() async {
    isLoading(true);
    try {
      var feedService = FeedService();
      var response = await feedService.fetchFeeds();
      feedList.clear(); // Clear the list before adding new data
      feedList.addAll(response);
    } catch (e) {
      print('Error fetching feeds: $e');
    } finally {
      isLoading(false);
    }
  }
}
