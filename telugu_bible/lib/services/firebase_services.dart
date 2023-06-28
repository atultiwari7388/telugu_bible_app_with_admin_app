import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telugu_bible/models/users_model.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

class FirebaseServices {
//================= Collection Sermon Notes ====================
  final CollectionReference sermonNotes =
      FirebaseFirestore.instance.collection("sermonNotes");

//================= Collection HolyBible ====================
  final CollectionReference holyBible =
      FirebaseFirestore.instance.collection("holyBible");

//==================== Store User Data to Firebase ========================

  Future<void> storeUserData(User user) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        // Add additional user data fields as per your requirements
      });
    } catch (e) {
      print('Error storing user data: $e');
    }
  }

  //=========================== Fetch User Data =================================

  Future<UserModel?> fetchUserDetails(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(
            documentSnapshot.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
    return null;
  }

  //=============================  Store data into Firebase ======================

  Future<void> storeDataToFirebase(
    Map<String, dynamic> newData,
  ) async {
    try {
      final docRef = await sermonNotes
          .add(newData)
          .then((value) =>
              showSnackBarMessage("Success", "New Data Added", Colors.green))
          .catchError((error) {
        log(error.toString());
        showSnackBarMessage("Error", error.toString(), Colors.red);
      });
      return docRef;
    } catch (e) {
      log(e.toString());
      showSnackBarMessage("Error", e.toString(), Colors.red);
    }
  }

//============================ Collection Name =======================
}
