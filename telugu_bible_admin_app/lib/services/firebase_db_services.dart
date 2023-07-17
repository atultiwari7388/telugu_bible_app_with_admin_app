import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:telugu_admin/screens/auth/login_screen.dart';

import '../constants/utils/toast_msg.utils.dart';

class FirebaseDatabaseServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //for users Collection
  final Stream<QuerySnapshot> customersList =
      FirebaseFirestore.instance.collection('users').snapshots();

//for appointments colllection
  final Stream<QuerySnapshot> totalBooks =
      FirebaseFirestore.instance.collection('books').snapshots();

  final Stream<QuerySnapshot> totalSermonNotes =
      FirebaseFirestore.instance.collection('sermonNotes').snapshots();

  //for holy bible section
  final CollectionReference holyBibleCollection =
      FirebaseFirestore.instance.collection("holyBible");

  //for English bible section
  final CollectionReference englishBibleCollection =
      FirebaseFirestore.instance.collection("englishBible");

  //for from the author section
  final CollectionReference fromTheAuthorCollection =
      FirebaseFirestore.instance.collection("fromTheAuthor");

  //for dailyQuotes section
  final CollectionReference dailyQuotesCollection =
      FirebaseFirestore.instance.collection("dailyQuote");

  final CollectionReference customerLists =
      FirebaseFirestore.instance.collection("users");
  //===================== Update user data by id ==============================

  Future<void> updateUserData(String id, Map<String, dynamic> updatedData) {
    return customerLists.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Add Telugu Bible data ==============================

  Future<void> addTeluguBibleData(Map<String, dynamic> newData) {
    return holyBibleCollection.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Add English Bible data ==============================

  Future<void> addEnglishBibleData(Map<String, dynamic> newData) {
    return englishBibleCollection.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Add From the Author Data ==============================

  Future<void> addFromTheAuthorData(Map<String, dynamic> newData) {
    return fromTheAuthorCollection.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//=================== Add Quotes Data ===================================

  Future<void> addQuotesData(Map<String, dynamic> newData) {
    return dailyQuotesCollection.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Delete telugu bible data by id ==============================

  Future<void> deleteTeluguBibleDataUsingID(id) {
    return holyBibleCollection.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

//===================== Delete English bible data by id ==============================

  Future<void> deleteEnglishBibleDataUsingID(id) {
    return englishBibleCollection.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

//===================== Delete From the Author data by id ==============================

  Future<void> deleteFromTheAuthorDataUsingID(id) {
    return fromTheAuthorCollection.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

//======================= Delete Quotes Data ============================
  Future<void> deleteQuoteDataUsingID(id) {
    return dailyQuotesCollection.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

//===================== Update data by id ==============================

  Future<void> editDataUsingId(String id, Map<String, dynamic> updatedData) {
    return holyBibleCollection.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//================= fetch data using uid =============================
  Future<DocumentSnapshot> getUserDetails(String uid) {
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  //====================== signOut from app =====================
  void signOut(BuildContext context) async {
    try {
      if (kIsWeb) {
        _auth.signOut().then((value) {
          showSnackBarMessage("Logout", "Logout Successfully", Colors.red);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
              (route) => false);
        });
      } else {
        await _auth.signOut().then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
              (route) => false);
        });
      }
    } catch (e) {
      showSnackBarMessage("Error", e.toString(), Colors.red);
    }
  }
}
