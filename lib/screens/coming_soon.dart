import 'package:flutter/material.dart';

class Comingsoon extends StatelessWidget {
  const Comingsoon({super.key});

  @override
  Widget build(BuildContext context) {
    // coming soon screen
    return const Scaffold(
      body: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
