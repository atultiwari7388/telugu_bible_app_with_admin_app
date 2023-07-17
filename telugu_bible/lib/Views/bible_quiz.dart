import 'package:flutter/material.dart';

class BibleQuizScreen extends StatelessWidget {
  const BibleQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Bible Quiz"),
        elevation: 0,
      ),
    );
  }
}
