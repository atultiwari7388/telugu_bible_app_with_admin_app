import 'package:flutter/material.dart';

class AdminSettingsScreen extends StatefulWidget {
  static const String id = "admin-setting";

  const AdminSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Setting Screen"),
      ),
    );
  }
}
