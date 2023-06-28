import 'package:flutter/material.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Search History Screen"),
        elevation: 0,
      ),
    );
  }
}
