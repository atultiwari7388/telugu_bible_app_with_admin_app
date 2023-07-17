import 'package:flutter/material.dart';

class HowtoUseAppScreen extends StatefulWidget {
  const HowtoUseAppScreen({super.key});

  @override
  State<HowtoUseAppScreen> createState() => _HowtoUseAppScreenState();
}

class _HowtoUseAppScreenState extends State<HowtoUseAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("How to use App"),
      ),
    );
  }
}
