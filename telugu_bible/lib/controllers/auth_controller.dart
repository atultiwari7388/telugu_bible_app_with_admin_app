import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telugu_bible/Views/home_screen.dart';
import 'package:telugu_bible/Views/login_screen.dart';
import 'package:telugu_bible/services/firebase_services.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //===================== Google sign in functionality ==================
  Future<bool> signInWithGoogle(BuildContext context) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // authenticate with firebase
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //get the credentials to (access / id token) from firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // get the userCredentials from authenticate
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseServices().storeUserData(user).then((value) {
            Get.off(() => const HomeScreen());
            showSnackBarMessage(
                "Success", "Welcome Back", AppColors.kPrimaryColor);
          });
        } else {
          Get.off(() => const HomeScreen());
          showSnackBarMessage(
              "Success", "Welcome Back", AppColors.kPrimaryColor);
        }
        result = true;
      } else{
         showSnackBarMessage(
              "Sorry", "You need to create your account first.", Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      result = false;
      showSnackBarMessage("Error", e.toString(), Colors.red);
    }
    return result;
  }


  //================== Logout ==============

  Future logout() async{
   try{
     await _auth.signOut().then((value) {
      Get.off(()=> const LoginScreen());
      showSnackBarMessage("Success", "Logout Success", AppColors.kPrimaryColor);
     });
   } catch (e){
     log(e.toString());
   }
  }






}
