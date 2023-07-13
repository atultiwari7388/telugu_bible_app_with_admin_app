// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_admin/constants/utils/styles.utils.dart';
// import 'package:telugu_admin/services/firebase_db_services.dart';
// import '../constants/utils/colors.utils.dart';

// class DashboardTotalAgentsData extends StatefulWidget {
//   const DashboardTotalAgentsData({Key? key}) : super(key: key);

//   @override
//   _DashboardTotalAgentsDataState createState() =>
//       _DashboardTotalAgentsDataState();
// }

// class _DashboardTotalAgentsDataState extends State<DashboardTotalAgentsData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Total Agents"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(18),
//           margin: const EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 50),
//               reusableRowHeadlineWidget(
//                 "#",
//                 "Name",
//                 "Email",
//                 "Phone",
//                 "Platform",
//                 "Permission",
//               ),
//               const SizedBox(height: 10),
//               StreamBuilder(
//                 stream: FirebaseDatabaseServices()
//                     .agentsList
//                     .where("role", isEqualTo: 1)
//                     .orderBy("created_at", descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: Lottie.asset("assets/loading.json", repeat: true),
//                     );
//                   }
//                   if (snapshot.hasData) {
//                     final List<QueryDocumentSnapshot> customerDocs =
//                         snapshot.data!.docs;
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: customerDocs.length,
//                       itemBuilder: (ctx, index) {
//                         final customer = customerDocs[index];
//                         final serialNumber = index + 1;
//                         final customerName = customer["name"];
//                         final customerEmail = customer["email"];
//                         final customerPhone = customer["phone"];
//                         final platformName = customer["platform"];
//                         final documentId = customer.id;
//                         // final permission = [""];

//                         return reusableRowWidget(
//                           serialNumber.toString(),
//                           customerName,
//                           customerEmail,
//                           customerPhone,
//                           platformName,
//                           "permission",
//                           documentId,
//                         );
//                       },
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     return const Text('Error fetching FAQs');
//                   } else {
//                     return Container();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget reusableRowWidget(
//       srNum, cName, cEmail, cPhone, platformName, permission, documentId) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Text(srNum, style: AppStyles.subtitleText),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(cName, style: AppStyles.subtitleText),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   cEmail,
//                   style: AppStyles.subtitleText,
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Text(
//                   cPhone,
//                   textAlign: TextAlign.center,
//                   style: AppStyles.subtitleText,
//                 ),
//               ),
//               const SizedBox(width: 40),
//               Expanded(
//                   flex: 1,
//                   child: Row(
//                     children: [
//                       Text(
//                         platformName,
//                         style: AppStyles.subtitleText,
//                         textAlign: TextAlign.center,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           buildEditDataWidget(platformName, documentId);
//                         },
//                         icon: const Icon(Icons.edit, color: Colors.green),
//                       )
//                     ],
//                   )),
//               Expanded(
//                 flex: 1,
//                 child: Switch(
//                   activeColor: Colors.green,
//                   value: true,
//                   onChanged: (value) {},
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Divider(),
//         ],
//       ),
//     );
//   }

//   Widget reusableRowHeadlineWidget(text1, text2, text3, text4, text5, text6) {
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
//           Expanded(
//             flex: 1,
//             child: Text(
//               text3,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text4,
//               textAlign: TextAlign.center,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text5,
//               textAlign: TextAlign.center,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Text(
//               text6,
//               textAlign: TextAlign.center,
//               style: AppStyles.subtitleText
//                   .copyWith(fontSize: 20, color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   //=================  Edit Data ===========================
//   Future buildEditDataWidget(selectedPlatform, uid) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
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
//                           selectedPlatform = item as String;
//                         });
//                       },
//                     ),

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
//                       FirebaseDatabaseServices().updateUserData(uid, {
//                         "platform": selectedPlatform,
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
// }
