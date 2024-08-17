import 'package:flutter/material.dart';
import '../models/user.dart';
import 'home_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final List<User> _messages = [
    User(name: 'George Bluth', lastMessage: 'test', timeStamp: '07:49 PM', profilePic: 'assets/profile1.jpg'),
    User(name: 'Janet Weaver', lastMessage: 'Cool! I have some feedbacks on this...', timeStamp: '09:38 PM', profilePic: 'assets/profile2.jpg'),
    User(name: 'Emma Wong', lastMessage: 'bu bir test mesajıdır :)', timeStamp: '07:49 PM', profilePic: 'assets/profile1.jpg'),
    User(name: 'Eve Holt', lastMessage: 'Cool! I have some feedbacks on this...', timeStamp: '09:38 PM', profilePic: 'assets/profile2.jpg'),
    User(name: 'Charles Morris', lastMessage: 'Cool! I have some feedbacks on this...', timeStamp: '09:38 PM', profilePic: 'assets/profile1.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Inbox',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: MessageDetailScreen(message: _messages[index]),
                    );
                  },
                  transitionDuration: Duration(milliseconds: 500),
                ),
              );
            },
            child: Card(
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(_messages[index].profilePic),
                ),
                title: Text(
                  _messages[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _messages[index].lastMessage,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _messages[index].timeStamp,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (index == 1 || index == 3 || index == 4) // Example for showing unread messages count
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
        backgroundColor: Colors.blueAccent,
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
        currentIndex: 1,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return HomeScreen();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return ProfileScreen();
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(-1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

class MessageDetailScreen extends StatelessWidget {
  final User message;

  MessageDetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: 'message-${message.name}',
          child: Card(
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
