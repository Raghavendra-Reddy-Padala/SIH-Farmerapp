import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intropage2 extends StatelessWidget {
  const Intropage2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight =
        MediaQuery.of(context).size.height; // Use height for consistent sizing

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: Text(
          "InstaFarm",
          style: GoogleFonts.pacifico(
            fontSize: _responsiveFontSize(context, 0.06),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Image.network(
                "https://th.bing.com/th/id/OIP.eh5RRJ5l1pqHQDN1ubb1VAHaEx?w=283&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'From Farm To Home\n',
                      style: GoogleFonts.gabarito(
                        fontSize: _responsiveFontSize(context, 0.06),
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text:
                          'Hello friends dengi tinar modda gudud tinava\nne peru enid ra', // Adjusted content
                      style: GoogleFonts.gabarito(
                        fontSize: _responsiveFontSize(context, 0.04),
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _responsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return baseSize * screenWidth;
  }
}
