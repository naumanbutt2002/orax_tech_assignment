class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  int likes;
  int comments;
  int shares;
  List<Comment> commentsList;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.commentsList = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class Comment {
  final String userName;
  final String text;
  final DateTime date;
  final int likes;
  final int dislikes;
  final String? avatarUrl;

  Comment({
    required this.userName,
    required this.text,
    required this.date,
    this.likes = 0,
    this.dislikes = 0,
    this.avatarUrl,
  });
}
