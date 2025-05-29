import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:orax_tech_assignment/models/post.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    // final response = await http.get(Uri.parse(baseUrl));
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json; charset=utf-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList()
        ..forEach((post) {
          post.likes = 10 + (post.id % 50); // Mock likes
          post.comments = 5 + (post.id % 20); // Mock comments
          post.shares = 2 + (post.id % 10); // Mock shares
          post.commentsList = [
            Comment(userName: 'User${post.userId}', text: 'Great post!', date: DateTime.now().subtract(Duration(days: 1))),
            Comment(userName: 'User${post.userId + 1}', text: 'Love this!', date: DateTime.now().subtract(Duration(days: 2))),
          ];
        });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> fetchPostById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'),
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Content-Type': 'application/json; charset=utf-8',
      },);
    if (response.statusCode == 200) {
      final post = Post.fromJson(json.decode(response.body));
      post.likes = 10 + (post.id % 50);
      post.comments = 5 + (post.id % 20);
      post.shares = 2 + (post.id % 10);
      post.commentsList = [
        Comment(
          userName: 'Sophia Clark',
          text: 'Sounds amazing! Where exactly did you go?',
          date: DateTime(2025, 11, 12),
          likes: 25,
          dislikes: 2,
          avatarUrl: 'https://i.pravatar.cc/150?img=47',
        ),
        Comment(
          userName: 'Ethan Carter',
          text: 'I’m so jealous! I need a break too.',
          date: DateTime(2025, 11, 12),
          likes: 18,
          dislikes: 1,
          avatarUrl: 'https://i.pravatar.cc/150?img=12',
        ),
        Comment(
          userName: 'Olivia Bennett',
          text: 'The mountains are calling, and I must go!',
          date: DateTime(2025, 11, 12),
          likes: 30,
          dislikes: 3,
          avatarUrl: 'https://i.pravatar.cc/150?img=56',
        ),
      ];
      return post;
    } else {
      throw Exception('Failed to load post');
    }
  }
}