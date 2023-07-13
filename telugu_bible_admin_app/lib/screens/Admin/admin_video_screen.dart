// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_admin/constants/utils/styles.utils.dart';
// import '../../constants/utils/colors.utils.dart';
// import '../../services/firebase_db_services.dart';

// class AdminVideoScreen extends StatefulWidget {
//   static const String id = "admin-video";

//   const AdminVideoScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminVideoScreen> createState() => _AdminVideoScreenState();
// }

// class _AdminVideoScreenState extends State<AdminVideoScreen> {
//   String formatDateWithTimeStamp(Timestamp timestamp) {
//     final DateTime dateTime = timestamp.toDate();
//     final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
//     return dateFormat.format(dateTime);
//   }

//   String? newSelectedPlatform;
//   String? newSelectedPlatformId;

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
//               Text("Videos", style: AppStyles.headlineText),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 onPressed: () => buildAddDataFunction(),
//                 child: Text(
//                   "Add More",
//                   style: AppStyles.subtitleText.copyWith(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 50),
//           reusableRowHeadlineWidget(
//               "#", "Link", "Name", "Platform Name", "Created", "Action"),
//           const SizedBox(height: 10),
//           StreamBuilder(
//             stream: FirebaseDatabaseServices()
//                 .videos
//                 .orderBy("created_at", descending: false)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Lottie.asset("assets/loading.json", repeat: true),
//                 );
//               }
//               if (snapshot.hasData) {
//                 final List<QueryDocumentSnapshot> videosDocs =
//                     snapshot.data!.docs;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: videosDocs.length,
//                   itemBuilder: (ctx, index) {
//                     final videoData = videosDocs[index];
//                     final serialNumber = index + 1;
//                     final video = videoData["video_link"];
//                     final platformTitle = videoData["name"];
//                     final platformName = videoData["platform_name"].toString();
//                     final platformId = videoData["platform_id"];
//                     final platformCreated = videoData["created_at"];
//                     final formattedDate =
//                         formatDateWithTimeStamp(platformCreated);
//                     final documentId = videoData.id;
//                     // final permission = [""];

//                     return reusableRowWidget(
//                       serialNumber.toString(),
//                       video,
//                       platformTitle,
//                       platformName,
//                       formattedDate,
//                       documentId,
//                       platformId,
//                     );
//                   },
//                 );
//               }
//               if (snapshot.hasError) {
//                 return const Text('Error fetching FAQs');
//               } else {
//                 return const Text('Error fetching FAQs');
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget reusableRowWidget(
//     text1,
//     video,
//     text2,
//     text3,
//     text4,
//     videoId,
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
//                   text1,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: TextButton(
//                   onPressed: () {
//                     Clipboard.setData(
//                       ClipboardData(
//                           text: "https://www.youtube.com/watch?v=$video"),
//                     );
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Meeting link copied')),
//                     );
//                   },
//                   child: Text("https://www.youtube.com/watch?v=$video"),
//                 ),
//               ),
//               const SizedBox(width: 30),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   text2,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   text3,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   text4,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               Expanded(
//                   child: Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         buildEditDataWidget(
//                           text3,
//                           videoId,
//                           text2,
//                           platformId,
//                           video,
//                         );
//                       },
//                       icon: const Icon(Icons.edit, color: Colors.green)),
//                   const SizedBox(width: 10),
//                   IconButton(
//                       onPressed: () {
//                         buildDeleteDataWidget(videoId);
//                       },
//                       icon: const Icon(Icons.delete, color: Colors.red)),
//                 ],
//               )),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Divider(),
//         ],
//       ),
//     );
//   }

//   Widget reusableRowHeadlineWidget(text1, text2, text3, text4, text5, action) {
//     return Container(
//       padding:
//           const EdgeInsets.only(top: 18.0, left: 10, right: 10, bottom: 10),
//       decoration: BoxDecoration(
//         color: AppColors.kPrimaryColor,
//         borderRadius: BorderRadius.circular(7),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Text(text1,
//                 style: AppStyles.subtitleText
//                     .copyWith(fontSize: 20, color: Colors.black)),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(text2,
//                 style: AppStyles.subtitleText
//                     .copyWith(fontSize: 20, color: Colors.black)),
//           ),
//           const SizedBox(width: 30),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text3,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text4,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text5,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               action,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// //===================  Delete Data =======================

//   Future buildDeleteDataWidget(videoId) {
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text("Faq Delete"),
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
//               FirebaseDatabaseServices().deleteVideoById(videoId);
//               Navigator.pop(context);
//             },
//             child: Text("Yes",
//                 style: AppStyles.subtitleText.copyWith(color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }

//   //=================  Edit Data ===========================
//   Future buildEditDataWidget(
//       selectedPlatform, videoId, name, platformId, video) {
//     final TextEditingController titleController =
//         TextEditingController(text: name);
//     final TextEditingController videoController =
//         TextEditingController(text: video);

//     return showDialog(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(builder: (ctx, setState) {
//           return FutureBuilder<QuerySnapshot>(
//             future: FirebaseDatabaseServices().platforms.get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Lottie.asset("assets/loading.json", repeat: true),
//                 );
//               }
//               if (snapshot.hasError) {
//                 return const Text('Error fetching platforms');
//               }
//               final List<QueryDocumentSnapshot> platformDocs =
//                   snapshot.data!.docs;
//               final List<String> platformOptions =
//                   platformDocs.map((doc) => doc['name'] as String).toList();
//               final List<String> platformIds =
//                   platformDocs.map((doc) => doc.id).toList();

//               return AlertDialog(
//                 title: const Text("Update Data"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Dropdown for platform selection
//                     DropdownButton<String>(
//                       value: selectedPlatform,
//                       items: platformOptions.map<DropdownMenuItem<String>>(
//                         (String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         },
//                       ).toList(),
//                       onChanged: (item) {
//                         setState(() {
//                           selectedPlatform = item;
//                           int index = platformOptions.indexOf(selectedPlatform);
//                           platformId = platformIds[index];
//                         });
//                       },
//                     ),

//                     // Text input for title
//                     TextField(
//                       controller: titleController,
//                       decoration: const InputDecoration(
//                         labelText: 'Title',
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // Text input for title
//                     TextField(
//                       controller: videoController,
//                       decoration: const InputDecoration(
//                         labelText: 'Enter Youtube link Code',
//                         hintText: "gxZ2K2HVesQ",
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // Text input for title
//                   ],
//                 ),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text("Cancel"),
//                   ),
//                   ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     onPressed: () {
//                       // Call the update functionality
//                       FirebaseDatabaseServices().editVideoById(videoId, {
//                         "platform_name": selectedPlatform,
//                         "name": titleController.text.toString(),
//                         "video_link": videoController.text.toString(),
//                         "platform_id": platformId,
//                         "updated_at": DateTime.now()
//                       });
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Submit"),
//                   ),
//                 ],
//               );
//             },
//           );
//         });
//       },
//     );
//   }

//   //================  Add data  ============================
//   Future buildAddDataFunction() {
//     final TextEditingController newTitleController = TextEditingController();
//     final TextEditingController videoController = TextEditingController();
//     return showDialog(
//       context: context,
//       builder: (ctx) {
//         return StatefulBuilder(builder: (ctx, setState) {
//           return FutureBuilder<QuerySnapshot>(
//             future: FirebaseDatabaseServices().platforms.get(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Lottie.asset("assets/loading.json", repeat: true),
//                 );
//               }
//               if (snapshot.hasError) {
//                 return const Text('Error fetching platforms');
//               }
//               // final List<QueryDocumentSnapshot> platformDocs =
//               //     snapshot.data!.docs;
//               // final List<String> platformOptions =
//               //     platformDocs.map((doc) => doc['name'] as String).toList();
//               // final List<String> platformIds =
//               //     platformDocs.map((doc) => doc.id).toList();

//               // // Set the initial value for newSelectedPlatform
//               // newSelectedPlatform =
//               //     platformOptions.isNotEmpty ? platformOptions[0] : '';

//               final List<QueryDocumentSnapshot> platformDocs =
//                   snapshot.data!.docs;
//               final List<String> platformOptions =
//                   platformDocs.map((doc) => doc['name'] as String).toList();
//               final List<String> platformIds =
//                   platformDocs.map((doc) => doc.id).toList();

//               if (newSelectedPlatform == null && platformOptions.isNotEmpty) {
//                 // Set the initial value for newSelectedPlatform
//                 newSelectedPlatform = platformOptions[0];
//               }

//               return AlertDialog(
//                 title: const Text("Update Data"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Dropdown for platform selection
//                     DropdownButton<String>(
//                       value: newSelectedPlatform,
//                       items: platformOptions.map<DropdownMenuItem<String>>(
//                         (String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         },
//                       ).toList(),
//                       onChanged: (item) {
//                         setState(() {
//                           newSelectedPlatform = item!;
//                         });
//                       },
//                     ),

//                     // Text input for title
//                     TextField(
//                       controller: newTitleController,
//                       decoration: const InputDecoration(
//                         labelText: 'Title',
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // Text input for description
//                     TextField(
//                       maxLines: 1,
//                       controller: videoController,
//                       decoration: const InputDecoration(
//                         labelText: "Video Link",
//                       ),
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text("Cancel"),
//                   ),
//                   ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                     onPressed: () {
//                       // Get the selected platform index
//                       int selectedPlatformIndex =
//                           platformOptions.indexOf(newSelectedPlatform!);

//                       // Get the corresponding platform ID
//                       String selectedPlatformId =
//                           platformIds[selectedPlatformIndex];

//                       // Call the addData functionality
//                       FirebaseDatabaseServices().addVideo({
//                         "created_at": DateTime.now(),
//                         "video_link": videoController.text.toString(),
//                         "name": newTitleController.text.toString(),
//                         "platform_name": newSelectedPlatform.toString(),
//                         "platform_id": selectedPlatformId,
//                         "updated_at": DateTime.now(),
//                         "timestamp": DateTime.now(),
//                       });
//                       Navigator.pop(context);
//                     },
//                     child: const Text("Submit"),
//                   ),
//                 ],
//               );
//             },
//           );
//         });
//       },
//     );
//   }
// }
