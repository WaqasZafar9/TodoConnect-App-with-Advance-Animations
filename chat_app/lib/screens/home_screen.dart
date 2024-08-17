import 'package:chat_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../widgets/animated_list_item.dart';
import '../widgets/page_transitions.dart';
import 'inbox_screen.dart';
import 'notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<User> _tasks = [
    User(name: 'Learn flutter', timeStamp: '10:00 AM'),
    User(name: 'Learn to handstand', timeStamp: '9:30 AM'),
    User(name: 'Play football', timeStamp: '8:45 AM'),
    User(name: 'Read Quran', timeStamp: '7:00 AM'),
  ];

  void _removeTask(int index) {
    final removedTask = _tasks[index];
    _tasks.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
          (context, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: _buildTaskItem(removedTask, index, isBeingDeleted: true),
          ),
        );
      },
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A2A6C),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "What's up, Mr Waqas!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xFF1A2A6C),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(createRoute(NotificationsScreen()));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'CATEGORIES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildCategoryCard('Business', 40),
                _buildCategoryCard('Sport', 32),
                _buildCategoryCard('Music', 21),
                _buildCategoryCard('Study', 14),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "TODAY'S TASKS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _tasks.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    child: _buildTaskItem(_tasks[index], index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTaskModal(context);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF18244A),
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white54,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(createRoute(InboxScreen()));
          } else if (index == 2) {
            Navigator.of(context).push(createRoute(ProfileScreen()));
          }
        },
      ),
    );
  }

  Widget _buildCategoryCard(String categoryName, int taskCount) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Color(0xFF18244A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$taskCount tasks',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(User task, int index, {bool isBeingDeleted = false}) {
    if (isBeingDeleted) {
      // Return an empty container to avoid being referenced after deletion
      return Container();
    }

    return Dismissible(
      key: ValueKey(task.name),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeTask(index);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFF344FA1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.radio_button_unchecked, color: Color(0xFF8E13BA)),
            SizedBox(width: 16),
            Text(
              task.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskScreen(onAddTask: (taskName) {
            _addTask(taskName);
          }),
        ),
      ),
    );
  }

  void _addTask(String taskName) {
    final newTask = User(
      name: taskName,
      timeStamp: 'Now',
    );
    setState(() {
      _tasks.insert(0, newTask);
      _listKey.currentState!.insertItem(0);
    });
  }
}

class AddTaskScreen extends StatelessWidget {
  final Function(String) onAddTask;
  late String enteredTaskName;

  AddTaskScreen({required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF18244A),
        border: Border.all(
          color: Color(0xFF18244A),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        decoration: BoxDecoration(
          color: Color(0xFF344FA1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'ADD NEW ITEM',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF8BA7EE),
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              margin: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2.0, color: Color(0xCBC7C7B3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextFormField(
                onChanged: (value) {
                  enteredTaskName = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'new item',
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  onAddTask(enteredTaskName);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 80.0),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xFF8BA7EE),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
