import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:orax_tech_assignment/models/post.dart';
import 'package:orax_tech_assignment/providers/post_provider.dart';

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}

class DetailPage extends StatelessWidget {
  final int postId;

  const DetailPage({super.key, required this.postId});

  String formatDate(DateTime date) => DateFormat('MMM d').format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Post',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Post?>(
        future: Provider.of<PostProvider>(context, listen: false).fetchPostById(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError || snapshot.data == null) return Center(child: Text('Error: ${snapshot.error ?? "Post not found"}'));

          final post = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  post.title.capitalize(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  post.body.replaceAll('\n', ' ').capitalize(),
                  style: const TextStyle(fontSize: 16.5, color: Colors.black87),
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${post.likes}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.comment_outlined, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${post.comments}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.share, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${post.shares}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Most Relevant', style: TextStyle(fontSize: 15.5, color: Colors.black87)),
                      const SizedBox(width: 4),
                      const Icon(CupertinoIcons.chevron_down, size: 20, color: Colors.black87),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: post.commentsList.length,
                    itemBuilder: (context, index) {
                      final comment = post.commentsList[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 20.0,
                          left: index == 0 ? 0 : 50, // Only indent comments after the first
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: comment.avatarUrl != null
                                  ? NetworkImage(comment.avatarUrl!)
                                  : null,
                              backgroundColor: Colors.grey[200],
                              child: comment.avatarUrl == null
                                  ? Text(
                                comment.userName[0].toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.5),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        formatDate(comment.date),
                                        style: const TextStyle(fontSize: 13.5, color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    comment.text,
                                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text('${comment.likes}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text('${comment.dislikes}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        // child: const Icon(Icons.person, color: Colors.black),
                        backgroundImage:NetworkImage('https://i.pravatar.cc/150?img=56'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Add comment...',
                                    border: InputBorder.none,
                                    hintStyle: const TextStyle(fontSize: 15),
                                  ),
                                  onSubmitted: (_) {},
                                ),
                              ),
                              const Icon(Icons.image, color: Colors.grey, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
