import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orax_tech_assignment/providers/post_provider.dart';
import 'package:orax_tech_assignment/screens/detail_page.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  // Map userId to a specific avatar image
  String getAvatarImage(int userId) {
    return 'assets/images/avatar_$userId.png'; // Maps userId 1 to avatar_1.png, userId 2 to avatar_2.png, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFC), // Set background color to #F7FAFC
      appBar: AppBar(
        backgroundColor: Color(0xFFF7FAFC), // Set background color to #F7FAFC
        title: const Text('Threads',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          print('Provider state - isLoading: ${provider.isLoading}, error: ${provider.error}, posts length: ${provider.posts.length}');
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }
          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              final username = 'User${post.userId}';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailPage(postId: post.id)),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar and Username Row (on top)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFF6DEC5),
                            child: ClipOval(
                              child: Image.asset(
                                getAvatarImage(post.userId),
                                width: 48, // Match diameter (2 * radius)
                                height: 48,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12), // Space between avatar and username
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  post.body.replaceAll('\n', ' ').capitalize(),
                                  style: const TextStyle(fontSize: 14, color: Color(0xFF436a97)),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4), // Space between content and timestamp
                                // Timestamp
                                Text(
                                  '${index + 1}d',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF436a97)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFF7FAFC), // Set background color to #F7FAFC
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0, // Highlight the "home" icon
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}