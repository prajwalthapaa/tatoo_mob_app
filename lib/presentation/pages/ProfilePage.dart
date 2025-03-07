import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'), // Replace with user image
            ),
            SizedBox(height: 10),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'johndoe@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+123 456 7890'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('New York, USA'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
