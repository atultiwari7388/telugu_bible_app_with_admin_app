// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_admin/constants/utils/styles.utils.dart';
// import 'package:telugu_admin/controller/upload_platform_image.dart';
// import '../../constants/utils/colors.utils.dart';
// import '../../services/firebase_db_services.dart';
// import 'package:get/get.dart';

// class AdminContactsScreen extends StatefulWidget {
//   static const String id = "admin-contact";

//   const AdminContactsScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminContactsScreen> createState() => _AdminContactsScreenState();
// }

// class _AdminContactsScreenState extends State<AdminContactsScreen> {
//   // final platformController = Get.put(PlatformUploadImageController());
//   final formKey = GlobalKey<FormState>();

//   String formatDateWithTimeStamp(Timestamp timestamp) {
//     final DateTime dateTime = timestamp.toDate();
//     final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
//     return dateFormat.format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       margin: const EdgeInsets.all(18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Contact", style: AppStyles.headlineText),
//               // ElevatedButton(
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: AppColors.kRedColor,
//               //   ),
//               //   onPressed: () => buildAddDataWidget(),
//               //   child: const Text("Add"),
//               // ),
//             ],
//           ),
//           // const SizedBox(height: 50),
//           // reusableRowHeadlineWidget(
//           //     "#", "Image", "Price", "Created", "Actions"),
//           // const SizedBox(height: 10),
//           // StreamBuilder(
//           //   stream: FirebaseDatabaseServices()
//           //       .platforms
//           //       .orderBy("created_at", descending: false)
//           //       .snapshots(),
//           //   builder: (context, snapshot) {
//           //     if (snapshot.connectionState == ConnectionState.waiting) {
//           //       return Center(
//           //         child: Lottie.asset("assets/loading.json", repeat: true),
//           //       );
//           //     }
//           //     if (snapshot.hasData) {
//           //       final List<QueryDocumentSnapshot> platformDocs =
//           //           snapshot.data!.docs;
//           //       return ListView.builder(
//           //         shrinkWrap: true,
//           //         physics: const NeverScrollableScrollPhysics(),
//           //         itemCount: platformDocs.length,
//           //         itemBuilder: (ctx, index) {
//           //           final platform = platformDocs[index];
//           //           final serialNumber = index + 1;
//           //           final platformImage = platform["image"];
//           //           // final platformName = platform["name"];
//           //           final platformPrice = platform["price"].toString();
//           //           final platformCreated = platform["created_at"];
//           //           final formattedDate =
//           //               formatDateWithTimeStamp(platformCreated);
//           //           // final permission = [""];
//           //           final platformId = platform.id;

//           //           return reusableRowWidget(
//           //             serialNumber.toString(),
//           //             platformImage,
//           //             platformPrice,
//           //             formattedDate,
//           //             platformId,
//           //           );
//           //         },
//           //       );
//           //     }
//           //     if (snapshot.hasError) {
//           //       return const Text('Error fetching FAQs');
//           //     } else {
//           //       return Container();
//           //     }
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget reusableRowWidget(
//     srNum,
//     image,
//     price,
//     created,
//     platformId,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   srNum,
//                   style: AppStyles.subtitleText,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               CachedNetworkImage(
//                 height: 80,
//                 width: 80,
//                 fit: BoxFit.cover,
//                 imageUrl: image,
//                 placeholder: (context, url) =>
//                     Lottie.asset("assets/loading.json", repeat: true),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               ),
//               Expanded(child: Container()),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   "\$$price",
//                   style: AppStyles.subtitleText,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   created,
//                   textAlign: TextAlign.center,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: ElevatedButton.icon(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     onPressed: () {
//                       buildEditDataWidget(platformId, price);
//                     },
//                     icon: const Icon(Icons.edit, color: Colors.white),
//                     label: const Text("Edit")),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Divider(),
//         ],
//       ),
//     );
//   }

//   Widget reusableRowHeadlineWidget(srNum, image, price, created, actions) {
//     return Container(
//       padding:
//           const EdgeInsets.only(top: 18.0, left: 10, right: 10, bottom: 10),
//       decoration: BoxDecoration(
//         color: AppColors.kPrimaryColor,
//         borderRadius: BorderRadius.circular(7),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(srNum,
//                 style: AppStyles.subtitleText
//                     .copyWith(fontSize: 20, color: Colors.black)),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(image,
//                 style: AppStyles.subtitleText
//                     .copyWith(fontSize: 20, color: Colors.black)),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               price,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               created,
//               textAlign: TextAlign.center,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               actions,
//               textAlign: TextAlign.center,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //===================  Delete Data =======================

//   Future buildDeleteDataWidget(platformId) {
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Platform Delete"),
//         content: const Text("Are you sure you want to Delete."),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("No",
//                 style: AppStyles.subtitleText
//                     .copyWith(color: AppColors.kRedColor)),
//           ),
//           TextButton(
//             onPressed: () {
//               // FirebaseDatabaseServices().deletePlatformUsingID(platformId);
//               Navigator.pop(context);
//             },
//             child: Text("Yes",
//                 style: AppStyles.subtitleText.copyWith(color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }

// //=================  Edit Data ===========================
//   Future buildEditDataWidget(platformId, price) {
//     final TextEditingController titleController =
//         TextEditingController(text: price);

//     return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             title: const Text("Update Data"),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Text input for title
//                 TextField(
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                     labelText: 'Price',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Text input for title
//               ],
//             ),
//             actions: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text("Cancel"),
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                 onPressed: () {
//                   // int parsedPrice = int.parse(titleController.text);
//                   // // Call the update functionality
//                   // FirebaseDatabaseServices().editPlatformUsingId(platformId,
//                   //     {"price": parsedPrice, "updated_at": DateTime.now()});
//                   // Navigator.pop(context);
//                 },
//                 child: const Text("Submit"),
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   //================= Add Platform Data  ===========================

//   Future buildAddDataWidget() {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             title: const Text("Add Data "),
//             content: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.all(10),
//                     child: Text("Platform ", style: AppStyles.headlineText),
//                   ),
//                   const Divider(color: AppColors.kLightGreyColor),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       const SizedBox(width: 30),
//                       Column(
//                         children: [
//                           //platfrom image
//                           Container(
//                             height: 150,
//                             width: 150,
//                             decoration: BoxDecoration(
//                               color: AppColors.kLightGreyColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: AppColors.kLightGreyColor
//                                       .withOpacity(.03)),
//                             ),
//                             child: Center(
//                                 child: platformController.image == null
//                                     ? const Text("Platform Image")
//                                     : Image.memory(platformController.image)),
//                           ),
//                           const SizedBox(height: 10),
//                           ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   platformController.uploadImage();
//                                 });
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 1,
//                                   backgroundColor: AppColors.kPrimaryColor),
//                               child: const Text("Upload Image")),
//                         ],
//                       ),
//                       const SizedBox(width: 20),
//                       SizedBox(
//                         width: 200,
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: platformController.name,
//                               validator: (valid) {
//                                 if (valid!.isEmpty) {
//                                   return "Please Enter Platform Name";
//                                 }
//                               },
//                               decoration: const InputDecoration(
//                                 label: Text("Enter Platform Name"),
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             TextFormField(
//                               controller: platformController.price,
//                               validator: (valid) {
//                                 if (valid!.isEmpty) {
//                                   return "Please Enter Platform Price";
//                                 }
//                               },
//                               decoration: const InputDecoration(
//                                 label: Text("Enter Platfrom Price"),
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             TextFormField(
//                               controller: platformController.colorCode,
//                               validator: (valid) {
//                                 if (valid!.isEmpty) {
//                                   return "Please Enter Platform Color Code";
//                                 }
//                               },
//                               decoration: const InputDecoration(
//                                 label: Text("Enter Platform Color Code"),
//                                 contentPadding: EdgeInsets.zero,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       OutlinedButton(
//                         onPressed: () => platformController.clear(),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: AppColors.kRedColor,
//                         ),
//                         child: const Text("Cancel"),
//                       ),
//                       const SizedBox(width: 10),
//                       platformController.image == null
//                           ? Container()
//                           : OutlinedButton(
//                               onPressed: () {
//                                 if (formKey.currentState!.validate()) {
//                                   platformController.saveImageToDB();
//                                   Navigator.pop(context);
//                                 }
//                               },
//                               style: OutlinedButton.styleFrom(
//                                   foregroundColor: Colors.green),
//                               child: const Text("Save"))
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   const Divider(color: AppColors.kLightGreyColor),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
