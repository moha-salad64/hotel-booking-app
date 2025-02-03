import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EditBooking extends StatefulWidget {
  final String bookingId;
  final String roomType;
  final DateTime checkIn;
  final DateTime checkOut;

  const EditBooking({
    super.key,
    required this.bookingId,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  State<EditBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  String? selectedRoomType;

  @override
  void initState() {
    super.initState();
    checkInController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.checkIn));
    checkOutController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.checkOut));
    selectedRoomType = widget.roomType;
  }

  Future<void> _updateBooking() async {
    try {
      await FirebaseFirestore.instance.collection('bookings').doc(widget.bookingId).update({
        'check_in': Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(checkInController.text)),
        'check_out': Timestamp.fromDate(DateFormat('dd/MM/yyyy').parse(checkOutController.text)),
        'room_type': selectedRoomType,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking updated successfully"), backgroundColor: Colors.green));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error updating booking: $e"), backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Booking")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
            controller: checkInController, 
            decoration:  InputDecoration(
              labelText: "Check-in Date",
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              )),
            ),
            SizedBox(height: 20),
            TextField(controller: checkOutController, 
            decoration: InputDecoration(
              labelText: "Check-out Date",
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
              )),
              ),
              const SizedBox(height: 20),
             DropdownButton<String>(
              value: selectedRoomType,
              onChanged: (newValue) => setState(() => selectedRoomType = newValue),
              items: ['Single', 'Double'].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:() {
                _updateBooking(); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18 , horizontal: 30),
              ),
              child: const Text("Update Booking" ,
              style:  const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white),
              )),
          ],
        ),
      ),
    );
  }
}
