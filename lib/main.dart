import 'package:flutter/material.dart';
import 'package:hotel_booking_app/components/slider1_page.dart';
import 'package:hotel_booking_app/components/slider2_page.dart';
import 'package:hotel_booking_app/components/slider3_page.dart';
import 'package:hotel_booking_app/start_page.dart';

void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SliderPage1(),
      // home: SliderPage2(),


       initialRoute: '/slider1',
      routes: {
        '/slider1': (context) => SliderPage1(),
        '/slider2': (context) => SliderPage2(),
        '/slider3': (context) => SliderPage3(),
        '/getstart': (context) => StartPage(),
      //   '/home': (context) => HomePage(),
      },



    )
  );
}

