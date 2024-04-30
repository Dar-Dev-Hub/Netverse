// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ArticleDetails extends StatelessWidget {
//   final box = GetStorage();

//   @override
//   Widget build(BuildContext context) {
//     final article = box.read('article');

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           article['title'],
//           style: GoogleFonts.rubik(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//             fontSize: 18.0,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 article['image'] ??
//                     'https://media.istockphoto.com/id/978975308/vector/upcoming-events-neon-signs-vector-upcoming-events-design-template-neon-sign-light-banner-neon.jpg?s=612x612&w=0&k=20&c=VMCoJJda9L17HVkFOFB3fyDpjC4Qu2AsyYn3u4T4F4c=',
//                 // Load the image from the provided URL
//                 width: double.infinity,
//                 fit: BoxFit.cover, // Adjust the fit as needed
//                 height: 200.0, // Adjust the height as needed
//               ),
//               SizedBox(height: 16.0), // Add spacing between image and text
//               Text(
//                 article['content'],
//                 style: GoogleFonts.rubik(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16.0,
//                 ),
//               ),
//               SizedBox(
//                   height: 16.0), // Add spacing between text and other details
//               Text(
//                 'Author: ${article['author'] ?? 'N/A'}',
//                 style: GoogleFonts.rubik(
//                   color: Colors.black87,
//                   fontSize: 14.0,
//                 ),
//               ),
//               Text(
//                 'Publication Date: ${article['publication_date']}',
//                 style: GoogleFonts.rubik(
//                   color: Colors.black87,
//                   fontSize: 14.0,
//                 ),
//               ),
//               // You can add more details as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetails extends StatelessWidget {
  final box = GetStorage();
  final format = DateFormat('MMMM dd,yyyy');

  ArticleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final article = box.read('article');
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    // DateTime dateTime = DateTime.parse(article['publishedAt'] ?? 'N/A');

    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: SizedBox(
              // padding: EdgeInsets.symmetric(horizontal: Kheight * 0.02),
              height: Kheight * 0.45,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: article['image'],
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            top: Kheight * 0.04,
            left: Kwidth * 0.04,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('${article['title']}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      '',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Linkify(
                    onOpen: _onOpen,
                    text: '${article['content']}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                // Text('${widget.newsContent}',
                //     maxLines: 20,
                //     style: GoogleFonts.poppins(
                //         fontSize: 15,
                //         color: Colors.black87,
                //         fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }
}
