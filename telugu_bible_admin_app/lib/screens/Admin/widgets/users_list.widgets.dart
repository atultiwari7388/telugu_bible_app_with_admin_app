import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';
import 'package:telugu_admin/widgets/dashboard_lcustomer_ist_data.dart';

class AllCustomersListScreen extends StatefulWidget {
  static const String id = "customers";

  const AllCustomersListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllCustomersListScreenState createState() => _AllCustomersListScreenState();
}

class _AllCustomersListScreenState extends State<AllCustomersListScreen> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Customer List", style: AppStyles.headlineText),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              //     onPressed: () => Get.to(() => const DashboardCustomersData()),
              //     child: Text("View More",
              //         style:
              //             AppStyles.subtitleText.copyWith(color: Colors.white)))
            ],
          ),
          const SizedBox(height: 50),
          reusableRowHeadlineWidget(
            "#",
            "Name",
            "Email",
            "Photo",
            "UID",
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: FirebaseDatabaseServices()
                .customerLists
                // .orderBy("created_at", descending: true)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/loading.json", repeat: true),
                );
              }

              if (snapshot.hasData) {
                final List<DocumentSnapshot> customerDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, index) {
                    final customerData = customerDocs[index];
                    final serialNumber = index + 1;
                    final name = customerData["displayName"] ?? "";
                    final email = customerData["email"] ?? "";
                    final photo = customerData["photoURL"] ?? "";
                    final uid = customerData["uid"] ?? "";

                    return reusableRowWidget(
                        serialNumber.toString(), name, email, photo, uid);
                  },
                );
              }
              if (snapshot.hasError) {
                return const Text('No Data Found');
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget reusableRowWidget(
    text1,
    name,
    email,
    photo,
    uid,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(text1, style: AppStyles.subtitleText),
              ),
              Expanded(
                flex: 1,
                child: Text(name, style: AppStyles.subtitleText),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  email,
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleText,
                ),
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(photo),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  uid,
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }

  Widget reusableRowHeadlineWidget(srNum, name, email, photo, uid) {
    return Container(
      padding:
          const EdgeInsets.only(top: 18.0, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(srNum,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text(name,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              email,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              photo,
              textAlign: TextAlign.center,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              uid,
              textAlign: TextAlign.center,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


  // return StreamBuilder<QuerySnapshot>(
    //   stream: customersList,
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       if (kDebugMode) {
    //         print('Something went Wrong');
    //       }
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: Lottie.asset("assets/loading.json", repeat: false),
    //       );
    //     }

    //     final List storedocs = [];
    //     snapshot.data!.docs.map((DocumentSnapshot document) {
    //       Map a = document.data() as Map<String, dynamic>;
    //       storedocs.add(a);
    //       a['id'] = document.id;
    //     }).toList();

    //     return Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    //       padding: const EdgeInsets.all(18),
    //       child: SingleChildScrollView(
    //         scrollDirection: Axis.vertical,
    //         child: Table(
    //           border: TableBorder.all(),
    //           // columnWidths: const <int, TableColumnWidth>{
    //           //   1: FixedColumnWidth(140),
    //           // },
    //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //           children: [
    //             TableRow(
    //               children: [
    //                 TableCell(
    //                   child: Container(
    //                     // color: Colors.greenAccent,
    //                     child: const Center(
    //                       child: Text(
    //                         'Name',
    //                         style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 TableCell(
    //                   child: Container(
    //                     // color: Colors.greenAccent,
    //                     child: const Center(
    //                       child: Text(
    //                         'Email Address',
    //                         style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 TableCell(
    //                   child: Container(
    //                     // color: Colors.greenAccent,
    //                     child: const Center(
    //                       child: Text(
    //                         'Phone',
    //                         style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 TableCell(
    //                   child: Container(
    //                     // color: Colors.greenAccent,
    //                     child: const Center(
    //                       child: Text(
    //                         'User Type',
    //                         style: TextStyle(
    //                           fontSize: 20.0,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 // TableCell(
    //                 //   child: Container(
    //                 //     // color: Colors.greenAccent,
    //                 //     child: const Center(
    //                 //       child: Text(
    //                 //         'Account Verified',
    //                 //         style: TextStyle(
    //                 //           fontSize: 20.0,
    //                 //           fontWeight: FontWeight.bold,
    //                 //         ),
    //                 //       ),
    //                 //     ),
    //                 //   ),
    //                 // ),
    //                 // TableCell(
    //                 //   child: Container(
    //                 //     // color: Colors.greenAccent,
    //                 //     child: const Center(
    //                 //       child: Text(
    //                 //         'Options',
    //                 //         style: TextStyle(
    //                 //           fontSize: 20.0,
    //                 //           fontWeight: FontWeight.bold,
    //                 //         ),
    //                 //       ),
    //                 //     ),
    //                 //   ),
    //                 // ),
    //               ],
    //             ),
    //             for (var i = 0; i < storedocs.length; i++) ...[
    //               TableRow(
    //                 children: [
    //                   TableCell(
    //                     child: Center(
    //                         child: Text(storedocs[i]['name'],
    //                             style: TextStyle(fontSize: 18.0))),
    //                   ),
    //                   TableCell(
    //                     child: Center(
    //                         child: Text(storedocs[i]['email'],
    //                             style: TextStyle(fontSize: 18.0))),
    //                   ),
    //                   TableCell(
    //                     child: Center(
    //                         child: Text(storedocs[i]['phone'],
    //                             style: TextStyle(fontSize: 18.0))),
    //                   ),
    //                   TableCell(
    //                     child: Center(
    //                         child: Text(storedocs[i]['role'].toString(),
    //                             style: TextStyle(fontSize: 18.0))),
    //                   ),

    //                   // //switch button
    //                   // TableCell(
    //                   //   child: Center(
    //                   //       child: Switch(
    //                   //     activeColor: Colors.green,
    //                   //     value: true,
    //                   //     onChanged: (value) {},
    //                   //   )),
    //                   // ),
    //                   // //options button
    //                   // TableCell(
    //                   //   child: Center(
    //                   //     child: Container(
    //                   //       padding: const EdgeInsets.all(8),
    //                   //       margin: const EdgeInsets.all(12),
    //                   //       height: 45,
    //                   //       decoration: BoxDecoration(
    //                   //         color: Colors.green,
    //                   //         borderRadius: BorderRadius.circular(5),
    //                   //       ),
    //                   //       child: Center(
    //                   //         child: Row(
    //                   //           mainAxisAlignment: MainAxisAlignment.center,
    //                   //           children: [
    //                   //             Text(
    //                   //               "Actions",
    //                   //               style: AppStyles.subtitleText
    //                   //                   .copyWith(color: AppColors.kWhiteColor),
    //                   //             ),
    //                   //             const SizedBox(width: 5),
    //                   //             DropdownButton(
    //                   //                 items: [], onChanged: (value) {})
    //                   //           ],
    //                   //         ),
    //                   //       ),
    //                   //     ),
    //                   //   ),
    //                   // ),
    //                 ],
    //               ),
    //             ],
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  
  