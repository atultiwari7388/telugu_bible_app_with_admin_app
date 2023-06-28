// import 'package:flutter/material.dart';

// class AllCategoriesListWidget extends StatelessWidget {
//   const AllCategoriesListWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     FirebaseServices services = FirebaseServices();
//     return StreamBuilder<QuerySnapshot>(
//         stream: services.categories.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Text("Something Error");
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.data!.size == 0) {
//             return Text("No Categories Added", style: AppStyles.subtitleText);
//           }

//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: snapshot.data!.size,
//             itemBuilder: (context, index) {
//               var categoryData = snapshot.data!.docs[index];
//               return Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Text(categoryData['categoryName']),
//                     // Image.network(categoryData['categoryImage']),
//                   ],
//                 ),
//               );
//             },
//           );
//         });
//   }
// }
