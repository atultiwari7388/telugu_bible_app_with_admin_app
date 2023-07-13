import 'package:flutter/material.dart';

class FromTheAuthorScreen extends StatefulWidget {
  const FromTheAuthorScreen({super.key});

  @override
  State<FromTheAuthorScreen> createState() => _FromTheAuthorScreenState();
}

class _FromTheAuthorScreenState extends State<FromTheAuthorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("From The Author"),
      ),
    );
  }
}
