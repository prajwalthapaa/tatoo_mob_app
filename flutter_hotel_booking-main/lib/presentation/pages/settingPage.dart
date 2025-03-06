import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../bloc/authBloc/auth_bloc.dart';
import 'LoginPage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ProfileSettingsPage(),
    NotificationSettingsPage(),
    AccountSettingsPage(),
    PrivacySettingsPage(),
    AboutUsPage(),
    ContactUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
              // Implement profile actions
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock),
            label: 'Privacy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact Us',
          ),
        ],
      ),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Update your profile settings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            SizedBox(height: 20),
            _buildInputField("Name", "Enter your name"),
            _buildInputField("Email", "Enter your email"),
            SizedBox(height: 20),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  // TextField with improved UI
  Widget _buildInputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blueAccent),
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.blueAccent.withOpacity(0.7)),
          filled: true,
          fillColor: Colors.blueAccent.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }

  // Save Button
  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implement save logic here
      },
      child: Text("Save Changes"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              title: "Push Notifications",
              icon: Icons.notifications_active,
              value: true,
              onChanged: (bool value) {},
            ),
            _buildCard(
              title: "Email Notifications",
              icon: Icons.email,
              value: false,
              onChanged: (bool value) {},
            ),
          ],
        ),
      ),
    );
  }

  // Custom Card for each setting
  Widget _buildCard(
      {required String title, required IconData icon, required bool value, required Function(bool) onChanged}) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(icon, color: Colors.blueAccent, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey[300],
        ),
      ),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOutState) {
          // Navigate to Login page after logging out
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to login page
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Account Settings", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Manage your account settings", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 20),
                _buildCard(
                  context,
                  onPressed: () {
                    // Dispatch the LogoutEvent
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                  title: "Logout",
                  icon: Icons.exit_to_app,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 16),
                _buildCard(
                  context,
                  onPressed: () {
                    // Implement delete account logic (if needed)
                  },
                  title: "Delete Account",
                  icon: Icons.delete_forever,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Custom card widget to style the buttons
  Widget _buildCard(BuildContext context,
      {required VoidCallback onPressed, required String title, required IconData icon, required Color color}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      shadowColor: color.withOpacity(0.3),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 28),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacySettingsPage extends StatefulWidget {
  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  // States for switches
  bool _twoFactorAuthEnabled = true;
  bool _shareDataWithThirdParties = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Settings",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Manage your privacy preferences here. Customize your privacy settings to control how your data is used.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 32),
              _buildSwitch(
                title: "Enable Two-Factor Authentication",
                value: _twoFactorAuthEnabled,
                onChanged: (newValue) {
                  setState(() {
                    _twoFactorAuthEnabled = newValue;
                  });
                },
              ),
              _buildSwitch(
                title: "Share Data with Third Parties",
                value: _shareDataWithThirdParties,
                onChanged: (newValue) {
                  setState(() {
                    _shareDataWithThirdParties = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blueAccent, // Active switch color
        inactiveThumbColor: Colors.grey, // Inactive thumb color
        inactiveTrackColor: Colors.grey.shade600, // Inactive track color
      ),
    );
  }
}

Widget _buildPage({required String title, required List<Widget> content}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        ...content,
      ],
    ),
  );
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Us",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/tatto-bg.jpg', // Add a relevant image of the tattoo shop
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Welcome to Ink Masters Tattoo Shop!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "We are a team of highly skilled artists dedicated to providing you with the best tattoo experience. Whether you're looking for a custom design or a classic piece, we strive to make your vision a reality. Our passion for tattoo art drives us to keep pushing the boundaries of creativity.",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 16),
                Text(
                  "Our Services:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "- Custom Tattoo Designs\n- Traditional & Neo-Traditional Tattoos\n- Black and Gray Tattoos\n- Color Tattoos\n- Cover-Ups & Touch-Ups\n- Piercings",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 16),
                Text(
                  "Contact Us:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "+1 234 567 890",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "contact@inkmasters.com",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Follow Us on Social Media:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
                      onPressed: () {
                        // Add Facebook link action
                      },
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.instagram, color: Colors.purple, size: 30),
                      onPressed: () {
                        // Add Instagram link action
                      },
                    ),
                    IconButton(
                      icon: Icon(LucideIcons.twitter, color: Colors.blueAccent, size: 30),
                      onPressed: () {
                        // Add Twitter link action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Us",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                "We'd love to hear from you! Feel free to reach out to us for any inquiries or support.",
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.email, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "contact@tattoosystem.com",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    "+1 234 567 890",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "Follow Us:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.facebook, color: Colors.blue, size: 30),
                    onPressed: () {
                      // Add Facebook link action
                    },
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.instagram, color: Colors.purple, size: 30),
                    onPressed: () {
                      // Add Instagram link action
                    },
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.twitter, color: Colors.blueAccent, size: 30),
                    onPressed: () {
                      // Add Twitter link action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
