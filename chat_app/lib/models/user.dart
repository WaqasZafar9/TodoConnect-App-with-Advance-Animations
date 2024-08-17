class User {
  final String name;
  final String lastMessage;
  final String timeStamp;
  final String profilePic;
  bool isDone;

  User({
    required this.name,
    this.lastMessage = '',
    this.timeStamp = '',
    this.profilePic = '',
    this.isDone = false, // New field for task completion status
  });
}
