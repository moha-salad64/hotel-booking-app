import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                sliderPage('images/slider1.jpeg', "Welcome", "Discover amazing hotels online!"),
                sliderPage('images/slider2.jpeg', "Easy Booking", "Book hotels anytime, anywhere."),
                sliderPage('images/slider3.jpeg', "Start Now", "Find the best hotel deals."),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index == currentIndex)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (currentIndex == 2) {
                Navigator.pushNamed(context, '/start');
              } else {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget sliderPage(String image, String title, String description) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(image, fit: BoxFit.cover),
        ),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(description, textAlign: TextAlign.center),
      ],
    );
  }

  Widget buildDot(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
