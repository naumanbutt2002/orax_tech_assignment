import 'package:flutter/material.dart';
import 'package:orax_tech_assignment/models/post.dart';
import 'package:orax_tech_assignment/services/api_service.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await ApiService().fetchPosts();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<Post?> fetchPostById(int id) async {
    try {
      return await ApiService().fetchPostById(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}