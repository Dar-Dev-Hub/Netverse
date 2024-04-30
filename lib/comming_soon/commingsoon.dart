import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Commingsoon extends StatelessWidget {
  const Commingsoon({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          // coming soon
          Center(
        child: Container(
          width: width * 0.9,
          height: height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white, // Set the container color to white
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Set the shadow color
                offset: const Offset(0, 3), // Set the shadow offset
                blurRadius: 7, // Set the shadow blur radius
                spreadRadius: 0, // Set the shadow spread radius
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.pending_actions_outlined,
                size: 50,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Coming Soon',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
