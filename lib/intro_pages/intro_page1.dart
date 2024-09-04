import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
                "https://miro.medium.com/max/3840/1*xMuIOwjliGUPjkzukeWKfw.jpeg",
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
                      text: 'InstaFarm\n',
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
