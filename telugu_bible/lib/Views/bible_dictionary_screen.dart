import 'package:flutter/material.dart';

class BibleDictionaryScreen extends StatelessWidget {
  const BibleDictionaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Bible Dictionary Screen"),
        elevation: 0,
      ),
    );
  }
}
