import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telugu_admin/constants/utils/toast_msg.utils.dart';
import 'package:telugu_admin/screens/dashboard/dashboard_screen.dart';

class AuthenticationController extends GetxController {
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //=================== login with same email and password =======================
  Future<void> loginWithEmailAndPass() async {
    isLoading = true;
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
      checkIfUserIsCustomerOrAdmin();
      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      showSnackBarMessage("Error", e.toString(), Colors.red);
    }
  }

  Future<void> checkIfUserIsCustomerOrAdmin() async {
    var ifUserIsExit = FirebaseFirestore.instance
        .collection("admin")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapShot) {
      if (snapShot.exists) {
        if (snapShot.get("role") == "admin") {
          showSnackBarMessage("Success", "Welcome back", Colors.green);
          //go to admin page
          Get.off(() => const AdminHomeScreen(),
              transition: Transition.leftToRightWithFade,
              duration: const Duration(seconds: 2));
        } else {
          showSnackBarMessage("Error",
              "You don't have permission to access this server", Colors.red);
        }
      } else {
        //
        showSnackBarMessage("Something Went wrong",
            "Document does not exists on the database", Colors.red);
      }
    });
  }
}
