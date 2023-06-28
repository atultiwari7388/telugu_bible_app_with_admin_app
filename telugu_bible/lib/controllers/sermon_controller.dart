import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/services/firebase_services.dart';

class SermonController extends GetxController {
  final FirebaseServices firebaseServices = FirebaseServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController titleController =
      TextEditingController(text: "NA");
  final TextEditingController speakerController =
      TextEditingController(text: "NA");
  final TextEditingController placeController =
      TextEditingController(text: "NA");

  //===================== Add SermonNote Function ======================
  void addSermonNotes() {
    firebaseServices.storeDataToFirebase({
      "title": titleController.text.toString(),
      "speaker": speakerController.text.toString(),
      "place": placeController.text.toString(),
      "date": DateTime.now(),
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
      "userId": auth.currentUser!.uid,
    });
  }
}
