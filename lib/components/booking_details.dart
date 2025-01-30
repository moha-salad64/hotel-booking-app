import 'package:flutter/material.dart';
import 'just_booking.dart';

class HotelDetailsScreen extends StatefulWidget {
  HotelDetailsScreen({super.key});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  final List<Map<String, dynamic>> hotels = [
    {'imageUrl': "images/slider3.jpeg", 'name': 'Jazeera Palace', 'location': 'Mogadishu, Somalia', 'rating': 4.5, 'price': 120},
    {'imageUrl': 'images/5.jpeg', 'name': 'Maka Al-Mukarama', 'location': 'Mogadishu, Somalia', 'rating': 4.8, 'price': 150},
    {'imageUrl': 'images/4.jpeg', 'name': 'Peace Hotel', 'location': 'Mogadishu, Somalia', 'rating': 4.3, 'price': 100},
    {'imageUrl': 'images/6.jpeg', 'name': 'Elite Hotel', 'location': 'Mogadishu, Somalia', 'rating': 4.6, 'price': 130},
  ];

  List<Map<String, dynamic>> filteredHotels = [];
  
  @override
  void initState() {
    super.initState();
    filteredHotels = hotels;
  }

  void _filterHotels(String query) {
    setState(() {
      filteredHotels = hotels.where((hotel) {
        return hotel['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Details about hotels',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 20),
        child: Column(
          children: [
            TextField(
              onChanged: _filterHotels,
              decoration: InputDecoration(
                hintText: 'Search for a hotel...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return HotelCard(hotel: hotel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${hotel['price']}/night',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
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
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                          hotel['rating'].toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      child: Text(" Hotel Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      child: Text(
                      'Jazeera Palace Hotel is an excellent choice for travelers visiting Mogadishu, offering many helpful amenities designed to enhance your stay. The rooms offer a minibar and air conditioning, and getting online is possible, as free internet access is available',
                      style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.6,
                      wordSpacing: 0.8
                    ),
                  ),                    )
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  // width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
