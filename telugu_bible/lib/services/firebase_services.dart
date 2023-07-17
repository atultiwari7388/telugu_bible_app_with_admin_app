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

//================= Collection EnglishBible ====================
  final CollectionReference englishBible =
      FirebaseFirestore.instance.collection("englishBible");

//================= From The Author ====================
  final CollectionReference fromTheAuthor =
      FirebaseFirestore.instance.collection("fromTheAuthor");

//================= Collection FavoriteDatas ====================
  final CollectionReference favorite =
      FirebaseFirestore.instance.collection("favorite");

  //================= Collection dailyQuotes of the day ====================
  final CollectionReference<Map<String, dynamic>> dailyQuotesOfTheDay =
      FirebaseFirestore.instance.collection("dailyQuote");

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
      log('Error storing user data: $e');
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
      log('Error fetching user details: $e');
    }
    return null;
  }

  //=============================  Store data into Firebase ======================

  Future<void> storeSermonDataToFirebase(
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

//========================= Edit Functionality ================================
  Future<void> editDataUsingId(String id, Map<String, dynamic> updatedData) {
    return sermonNotes.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//============================= delete data to firebase =======================

  Future<void> deleteSermonDataUsingId(id) {
    return sermonNotes.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

//============================ Collection Name =======================
}
