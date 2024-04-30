import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: CustomSnackBarContent(
                  title: '',
                  message: '',
                  bgcolor: Colors.red,
                  bubcolor: Colors.red,
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            );
          },
          child: const Text('Show Snack Message'),
        ),
      ),
    );
  }
}

class CustomSnackBarContent extends StatelessWidget {
  final String title;
  final String message;
  final Color bgcolor;
  final Color bubcolor;

  const CustomSnackBarContent({
    super.key,
    required this.title,
    required this.message,
    required this.bgcolor,
    required this.bubcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: bgcolor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, // Non-constant value here
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              "assets/Icons/bubbles.svg",
              height: 48,
              width: 40,
              color: bubcolor,
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/Icons/fail.svg",
                height: 40,
                color: bubcolor,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/Icons/close.svg",
                  height: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
