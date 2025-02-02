import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final String? bookingId;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final String? roomType;

  const BookingScreen({
    super.key,
    this.bookingId,
    this.checkIn,
    this.checkOut,
    this.roomType,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  String selectedRoomType = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkInDate = widget.checkIn;
    checkOutDate = widget.checkOut;
    selectedRoomType = widget.roomType ?? "";
  }

  Future<void> _saveBooking() async {
    if (checkInDate == null || checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both check-in and check-out dates.')),
      );
      return;
    }

    try {
      if (widget.bookingId == null) {
        await _firestore.collection('bookings').add({
          'check_in': checkInDate,
          'check_out': checkOutDate,
          'room_type': selectedRoomType,
          'created_at': Timestamp.now(),
        });
      } else {
        await _firestore.collection('bookings').doc(widget.bookingId).update({
          'check_in': checkInDate,
          'check_out': checkOutDate,
          'room_type': selectedRoomType,
        });
      }

      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving booking: $e')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Booking Successful"),
          content: const Text("Your booking has been successfully saved."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Check-in Date Picker
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: checkInDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => checkInDate = date);
                }
              },
              child: Text("Check-in Date: ${checkInDate ?? "Not selected"}"),
            ),
            // Check-out Date Picker
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: checkOutDate ?? DateTime.now(),
                  firstDate: checkInDate ?? DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => checkOutDate = date);
                }
              },
              child: Text("Check-out Date: ${checkOutDate ?? "Not selected"}"),
            ),
            // Room Type Selection
            DropdownButton<String>(
              value: selectedRoomType.isNotEmpty ? selectedRoomType : null,
              hint: const Text("Select Room Type"),
              items: ["Single", "Double"].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedRoomType = value!);
              },
            ),
            // Save Button
            ElevatedButton(
              onPressed: _saveBooking,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
