import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orax_tech_assignment/providers/post_provider.dart';
import 'package:orax_tech_assignment/screens/listing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider()..fetchPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orax Tech Assignment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ListingPage(),
      ),
    );
  }
}