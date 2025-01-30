import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.green.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'My Booking',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bookings') // Your Firestore collection name
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No bookings found"));
                    }

                    final bookings = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        final checkIn = booking['check_in'].toDate();
                        final checkOut = booking['check_out'].toDate();
                        final roomType = booking['room_type'];

                        return BookingCard(
                          roomType: roomType,
                          checkIn: '${checkIn.day}/${checkIn.month}/${checkIn.year}',
                          checkOut: '${checkOut.day}/${checkOut.month}/${checkOut.year}',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String roomType;
  final String checkIn;
  final String checkOut;

  const BookingCard({
    super.key,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.amber.shade300,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Room Type: $roomType',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20), 
          Text(
            'Check-in: $checkIn',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Check-out: $checkOut',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20), 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add cancel booking logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10), // Add space between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Add edit booking logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
