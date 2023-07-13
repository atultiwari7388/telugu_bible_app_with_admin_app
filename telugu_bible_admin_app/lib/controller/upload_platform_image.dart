// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:telugu_admin/constants/utils/colors.utils.dart';
// import 'package:telugu_admin/constants/utils/toast_msg.utils.dart';
// import 'package:telugu_admin/services/firebase_db_services.dart';

// class PlatformUploadImageController extends GetxController {
//   final TextEditingController name = TextEditingController();
//   final TextEditingController price = TextEditingController();
//   final TextEditingController colorCode =
//       TextEditingController(text: "#FF9900");

//   dynamic image;
//   String? fileName;

//   FirebaseDatabaseServices services = FirebaseDatabaseServices();

//   //upload image
//   uploadImage() async {
//     FilePickerResult? result = await FilePicker.platform
//         .pickFiles(type: FileType.image, allowMultiple: false);

//     if (result != null) {
//       image = result.files.first.bytes;
//       fileName = result.files.first.name;
//       update();
//     } else {
//       //failed to pick image or user cancel
//       showSnackBarMessage("Error", "Failed ", Colors.red);
//     }
//   }

// //save image to database

//   saveImageToDB() async {
//     EasyLoading.show();
//     //save image to firebase storage
//     var reference = firebase_storage.FirebaseStorage.instance
//         .ref("platfromImages/$fileName");
//     try {
//       await reference.putData(image);
//       //get downloaded url to save image url in fireStore database
//       String downloadedUrl = await reference.getDownloadURL().then((value) {
//         if (value.isNotEmpty) {
//           //save data to fireStore
//           services.addPlatform({
//             "color_code": colorCode.text.toString(),
//             "image": value,
//             "name": name.text.toString(),
//             "price": price.text.toString(),
//             "created_at": DateTime.now(),
//             "updated_at": DateTime.now(),
//           }).then((value) {
//             //after save the image clear all the data from screen
//             clear();
//             EasyLoading.dismiss();
//           });
//           showSnackBarMessage("Success", "Upload done", Colors.green);
//         }
//         return value;
//       });
//     } on FirebaseException catch (e) {
//       clear();
//       EasyLoading.dismiss();
//       showSnackBarMessage("Error", e.toString(), AppColors.kRedColor);
//     }
//   }

//   clear() {
//     name.clear();
//     price.clear();
//     image = null;
//     update();
//   }
// }
