import 'package:flutter/material.dart';
import '../models/user.dart';

class AnimatedListItem extends StatelessWidget {
  final User user;
  final Animation<double> animation;
  final VoidCallback onRemove;
  final VoidCallback onToggleDone;

  AnimatedListItem({
    required this.user,
    required this.animation,
    required this.onRemove,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    final slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ));

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: slideAnimation,
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: user.isDone ? Colors.green : Colors.red,
              child: IconButton(
                icon: Icon(
                  user.isDone ? Icons.check : Icons.radio_button_unchecked,
                  color: Colors.white,
                ),
                onPressed: onToggleDone,
              ),
            ),
            title: Text(
              user.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: user.isDone ? TextDecoration.lineThrough : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
        ),
      ),
    );
  }
}
