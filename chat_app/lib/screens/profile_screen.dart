import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'inbox_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Navigate to settings screen with custom transition

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Hero(
                  tag: 'profile-pic',
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/profile_pic.jpg'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'M WAQAS ZAFAR',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                '@waqaszafar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              _buildProfileOption(
                context,
                icon: Icons.info,
                title: 'About Me',
                subtitle: 'A short bio about yourself',
                onTap: () {
                  // Navigate to About section with custom transition

                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.phone,
                title: 'Contact Info',
                subtitle: 'Phone number, email, etc.',
                onTap: () {
                  // Navigate to Contact Information with custom transition

                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.lock,
                title: 'Privacy Settings',
                subtitle: 'Manage your privacy settings',
                onTap: () {
                  // Navigate to Privacy Settings with custom transition

                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.notifications,
                title: 'Notification Settings',
                subtitle: 'Manage your notifications',
                onTap: () {
                  // Navigate to Notification Settings with custom transition

                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.block,
                title: 'Blocked Contacts',
                subtitle: 'Manage your block list',
                onTap: () {
                  // Navigate to Block List with custom transition

                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox, size: 30),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(_createSlidePageRoute(HomeScreen()));
              break;
            case 1:
              Navigator.of(context).push(_createSlidePageRoute(InboxScreen()));
              break;
            case 2:
            // Already on Profile screen
              break;
          }
        },
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }

  PageRouteBuilder _createSlidePageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }
}
