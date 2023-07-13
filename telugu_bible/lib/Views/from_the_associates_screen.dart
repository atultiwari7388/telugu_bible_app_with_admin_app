import 'package:flutter/material.dart';

class FromTheAssociatesScreen extends StatefulWidget {
  const FromTheAssociatesScreen({super.key});

  @override
  State<FromTheAssociatesScreen> createState() =>
      _FromTheAssociatesScreenState();
}

class _FromTheAssociatesScreenState extends State<FromTheAssociatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("From The Associates Screen"),
      ),
    );
  }
}
