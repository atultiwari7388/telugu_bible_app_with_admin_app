import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telugu_bible/services/firebase_services.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

class SermonController extends GetxController {
  final FirebaseServices firebaseServices = FirebaseServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController titleController =
      TextEditingController(text: "NA");
  final TextEditingController speakerController =
      TextEditingController(text: "NA");
  final TextEditingController placeController =
      TextEditingController(text: "NA");
  final TextEditingController referenceController =
      TextEditingController(text: "NA");

  //===================== Add SermonNote Function ======================
  void addSermonNotes(DateTime selectedDate, TimeOfDay selectedTime) {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    final String formattedTime =
        '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}';
    firebaseServices.storeSermonDataToFirebase({
      "title": titleController.text.toString(),
      "speaker": speakerController.text.toString(),
      "place": placeController.text.toString(),
      "reference": referenceController.text.toString(),
      "date": formattedDate,
      "time": formattedTime,
      "created_at": DateTime.now(),
      "updated_at": DateTime.now(),
      "userId": auth.currentUser!.uid,
    });
  }

//========================== Edit Functionality ============================

  void editData(String id, Map<String, dynamic> updatedData) {
    firebaseServices.editDataUsingId(id, updatedData);
  }

//=========================== delete Functionality ============================

  void deleteData(String id) {
    firebaseServices.deleteSermonDataUsingId(id);
  }
}
