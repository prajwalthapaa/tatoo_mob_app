import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelsPage extends StatefulWidget {
  HotelsPage({super.key});

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  final List<Map<String, dynamic>> dummyBookings = [
    {
      'tattoo': 'Dragon Tattoo',
      'date': DateTime(2025, 5, 10),
    },
    {
      'tattoo': 'Rose Tattoo',
      'date': DateTime(2025, 5, 12),
    },
    {
      'tattoo': 'Skull Tattoo',
      'date': DateTime(2025, 5, 14),
    },
    {
      'tattoo': 'Phoenix Tattoo',
      'date': DateTime(2025, 5, 16),
    },
  ];

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Booking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Booking Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // Displaying the dummy bookings as a list
            Expanded(
              child: ListView.builder(
                itemCount: dummyBookings.length,
                itemBuilder: (context, index) {
                  final booking = dummyBookings[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        booking['tattoo'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Appointment Date: ${DateFormat.yMMMd().format(booking['date'])}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action for back button (could be to go to booking page or perform another action)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Back to Booking", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
