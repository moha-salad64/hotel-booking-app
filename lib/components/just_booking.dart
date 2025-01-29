import 'package:flutter/material.dart';

class JustBooking extends StatefulWidget {
  const JustBooking({super.key});

  @override
  State<JustBooking> createState() => _JustBookingState();
}

class _JustBookingState extends State<JustBooking> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Just Booking"
      ),
    );
  }
}