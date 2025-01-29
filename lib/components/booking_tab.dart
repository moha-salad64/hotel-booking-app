import 'package:flutter/material.dart';
import 'just_booking.dart';


class HotelDetailsScreen extends StatelessWidget {

  HotelDetailsScreen({super.key});

  final List<Map<String, dynamic>> hotels = [
    {
      'imageUrl': "images/1.jpeg",
      'name': 'Jazeera Palace',
      'location': 'Mogadishu, Somalia',
      'rating': 4.5,
      'price': 120,
    },
    {
      'imageUrl': 'images/10.jpeg',
      'name': 'Maka Al-Mukarama',
      'location': 'Mogadishu, Somalia',
      'rating': 4.8,
      'price': 150,
    },
    {
      'imageUrl': 'images/4.jpeg',
      'name': 'Peace Hotel',
      'location': 'Mogadishu, Somalia',
      'rating': 4.3,
      'price': 100,
    },
      {
      'imageUrl': 'images/6.jpeg',
      'name': 'Peace Hotel',
      'location': 'Mogadishu, Somalia',
      'rating': 4.3,
      'price': 100,
    },
  ];

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Hotel Listings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, ),
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    hotel['imageUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hotel['name'],
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${hotel['price']}/night',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(
                                hotel['location'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              Text(
                                hotel['rating'].toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print("navigator to the bookin at");
                            Navigator.push(
                              context,
                              MaterialPageRoute( builder: (context) => const JustBooking()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
