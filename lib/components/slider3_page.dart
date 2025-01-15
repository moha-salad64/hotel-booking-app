import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SliderPage3 extends StatefulWidget {
  const SliderPage3({super.key});

  @override
  _SliderPage1State createState() => _SliderPage1State();
}

class _SliderPage1State extends State<SliderPage3> {
  int currentIndex = 0; // Tracks the current active page

  void goToNextPage() {
    setState(() {
      if (currentIndex < 3) {
        currentIndex++;
        if (currentIndex == 2) {
          // Navigate to SliderPage2 when at the second dot
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SliderPage3()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA6CDC6),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 550,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/slider3.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 45.0),
          Container(
            child: Column(
              children: [
                Text(
                  "Booking Hotel as Online",
                  style: GoogleFonts.acme(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Booking the hotel you want without even visiting, all online!',
                  style: GoogleFonts.acme(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60.0),
            child: ElevatedButton(
              onPressed: () {
                goToNextPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              ),
              child: Text(
                'Next',
                style: GoogleFonts.acme(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(currentIndex == 0),
                  buildDot(currentIndex == 1),
                  buildDot(currentIndex == 2),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            child: Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      // Add skip logic (e.g., navigate to main page)
                    },
                    child: Text(
                      'Skip',
                      style: GoogleFonts.acme(
                        fontSize: 17,
                        color: const Color(0xff000957),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade800 : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
