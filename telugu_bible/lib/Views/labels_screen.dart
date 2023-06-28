import 'package:flutter/material.dart';

class LabelsScreen extends StatelessWidget {
  const LabelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Labels Screen"),
        elevation: 0,
      ),
    );
  }
}
