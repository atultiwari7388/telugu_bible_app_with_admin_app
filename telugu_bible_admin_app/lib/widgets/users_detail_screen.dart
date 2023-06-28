import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersDetailsScreen extends StatefulWidget {
  const UsersDetailsScreen({super.key, required this.uid});

  final String uid;

  @override
  State<UsersDetailsScreen> createState() => _UsersDetailsScreenState();
}

class _UsersDetailsScreenState extends State<UsersDetailsScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late DocumentSnapshot userSnapshot;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot snapshot =
          await firestore.collection('users').doc(widget.uid).get();

      setState(() {
        userSnapshot = snapshot;
      });
    } catch (error) {
      // Handle the error gracefully
      log('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userSnapshot["name"].toString()),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userSnapshot != null) ...[
            Text('User ID: ${widget.uid}'),
            Text('Name: ${userSnapshot['name']}'),
            Text('Email: ${userSnapshot['email']}'),
            // Add more widgets to display other user details
          ] else ...[
            Text('Loading user data...'),
          ],
        ],
      ),
    );
  }
}
