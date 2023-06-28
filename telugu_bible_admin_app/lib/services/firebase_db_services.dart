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

  //for faqs section
  final CollectionReference holyBibleCollection =
      FirebaseFirestore.instance.collection("holyBible");

  final CollectionReference customerLists =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference agentsList =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference appointments =
      FirebaseFirestore.instance.collection("appointment_booking");

  final CollectionReference platforms =
      FirebaseFirestore.instance.collection("platforms");

  final CollectionReference videos =
      FirebaseFirestore.instance.collection("videos");

  //===================== Add Platform ==============================

  Future<void> addPlatform(Map<String, dynamic> newData) {
    return platforms.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Update data by id ==============================

  Future<void> editPlatformUsingId(
      String id, Map<String, dynamic> updatedData) {
    return platforms.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

  //===================== Delete Platforms by id ==============================

  Future<void> deletePlatformUsingID(id) {
    return platforms.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

  //===================== Update user data by id ==============================

  Future<void> updateUserData(String id, Map<String, dynamic> updatedData) {
    return customerLists.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Delete video by id ==============================

  Future<void> deleteVideoById(id) {
    return videos.doc(id).delete().then((value) {
      showSnackBarMessage("Deleted", "Data Deleted", Colors.red);
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => showSnackBarMessage(
            "Something went Wrong", error.toString(), Colors.red));
  }

  //===================== Update Video data by id ==============================

  Future<void> editVideoById(String id, Map<String, dynamic> updatedData) {
    return videos.doc(id).update(updatedData).then((value) {
      showSnackBarMessage("Updated", "Data Updated", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

  //===================== Add Video ==============================

  Future<void> addVideo(Map<String, dynamic> newData) {
    return videos.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => showSnackBarMessage(
        "Something went wrong", error.toString(), Colors.red));
  }

//===================== Delete faq by id ==============================

  Future<void> deleteDataUsingID(id) {
    return holyBibleCollection.doc(id).delete().then((value) {
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

//===================== Add data by id ==============================

  Future<void> addData(Map<String, dynamic> newData) {
    return holyBibleCollection.add(newData).then((value) {
      showSnackBarMessage("Added", "New Data Added", Colors.green);
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
