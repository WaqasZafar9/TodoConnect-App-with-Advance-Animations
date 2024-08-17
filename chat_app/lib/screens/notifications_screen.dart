import 'package:flutter/material.dart';
import '../widgets/animated_list_item.dart';
import '../models/user.dart';
import 'inbox_screen.dart';
import 'profile_screen.dart';
import 'home_screen.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<User> _notifications = [
    User(name: 'Notification 1', lastMessage: 'You have a new message', timeStamp: '10:00 AM', profilePic: 'assets/profile1.jpg'),
    User(name: 'Notification 2', lastMessage: 'Friend request from Alice', timeStamp: '9:30 AM', profilePic: 'assets/profile2.jpg'),
    User(name: 'Notification 3', lastMessage: 'Mentioned in a post', timeStamp: 'Yesterday', profilePic: 'assets/profile1.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Arial',
          ),
        ),
        backgroundColor: Colors.white, // Replace with your brand color
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Dismissible(
                  key: Key(notification.name),
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(notification.profilePic),
                    ),
                    title: Text(notification.name, style: TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold)),
                    subtitle: Text(notification.lastMessage),
                    trailing: Text(notification.timeStamp, style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      // Navigate to relevant screen
                    },
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _notifications.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                padding: EdgeInsets.all(30),
              ),
              child: Text('Clear Notifications'),
            ),
          ),
        ],

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
            icon: Icon(Icons.notifications, size: 30),
            label: 'Notifications',
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InboxScreen()));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsScreen()));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
              break;
          }
        },
      ),
    );
  }
}
