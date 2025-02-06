import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'edit_booking.dart';

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
                  stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No bookings found"));
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
                        final bookingId = booking.id;

                        return BookingCard(
                          bookingId: bookingId,
                          roomType: roomType,
                          checkIn: checkIn,
                          checkOut: checkOut,
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
  final String bookingId;
  final String roomType;
  final DateTime checkIn;
  final DateTime checkOut;

  const BookingCard({
    super.key,
    required this.bookingId,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
  });

  void _editBooking(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBooking(
          bookingId: bookingId,
          roomType: roomType,
          checkIn: checkIn,
          checkOut: checkOut,
        ),
      ),
    );
  }

  void _deleteBooking(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Booking"),
          content: const Text("Are you sure you want to delete this booking?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking deleted successfully"), backgroundColor: Colors.green),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error deleting booking: $e"), backgroundColor: Colors.red),
                  );
                }
                Navigator.of(context).pop(); 
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Room Type: $roomType', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text('Check-in: ${DateFormat('dd/MM/yyyy').format(checkIn)}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text('Check-out: ${DateFormat('dd/MM/yyyy').format(checkOut)}', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _deleteBooking(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _editBooking(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                child: const Text('Update', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
