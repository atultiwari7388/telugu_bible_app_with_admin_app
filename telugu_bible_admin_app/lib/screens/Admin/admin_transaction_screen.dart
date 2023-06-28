import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import '../../constants/utils/colors.utils.dart';
import '../../services/firebase_db_services.dart';

class AdminBibleDictionaryScreen extends StatefulWidget {
  static const String id = "admin-bible-dictionary";

  const AdminBibleDictionaryScreen({Key? key}) : super(key: key);

  @override
  State<AdminBibleDictionaryScreen> createState() =>
      _AdminBibleDictionaryScreenState();
}

class _AdminBibleDictionaryScreenState
    extends State<AdminBibleDictionaryScreen> {
  String formatDateWithTimeStamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

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
              Text("Bible Disctionary", style: AppStyles.headlineText),
            ],
          ),
          // const SizedBox(height: 50),
          // reusableRowHeadlineWidget(
          //   "#",
          //   // "A-Name",
          //   "C-Name",
          //   "Amount",
          //   "Payment Status",
          //   "Platform",
          //   "Created",
          // ),
          // const SizedBox(height: 10),
          // FutureBuilder(
          //   future: FirebaseDatabaseServices()
          //       .appointments
          //       .orderBy("created_at", descending: true)
          //       .get(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: Lottie.asset("assets/loading.json", repeat: true),
          //       );
          //     }
          //     if (snapshot.hasData) {
          //       final List<DocumentSnapshot> appointmentDocs =
          //           snapshot.data!.docs;
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: appointmentDocs.length,
          //         itemBuilder: (ctx, index) {
          //           final appointment = appointmentDocs[index];
          //           final serialNumber = index + 1;
          //           final amount = appointment["amount"] ?? "";
          //           final status = appointment["payment_status"] ?? "";
          //           final platform = appointment["platform"] ?? "";
          //           final userId = appointment["user_id"];
          //           final finalAmount = amount.substring(0, 2);
          //           final createdDate = appointment["created_at"];
          //           final formatedDate = formatDateWithTimeStamp(createdDate);

          //           return reusableRowWidget(
          //             serialNumber.toString(),
          //             // agentId,
          //             userId,
          //             "\$$finalAmount",
          //             "Online /$status",
          //             platform,
          //             formatedDate,

          //             // meetingLink != null ? meetingLink.toString() : 'null',
          //           );
          //         },
          //       );
          //     }
          //     if (snapshot.hasError) {
          //       return const Text('Error fetching FAQs');
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget reusableRowWidget(
    serialNum,
    customerId,
    amount,
    status,
    platform,
    createdDate,
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
                child: Text(serialNum, style: AppStyles.subtitleText),
              ),
              // Expanded(
              //   flex: 1,
              //   child: FutureBuilder(
              //     future: FirebaseDatabaseServices().getUserDetails(agentId),
              //     builder: (ctx, snap) {
              //       if (snap.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child:
              //               Lottie.asset("assets/loading.json", repeat: true),
              //         ); // Show a loading indicator while fetching data
              //       }

              //       if (snap.hasData) {
              //         final agentData =
              //             snap.data!.data() as Map<String, dynamic>;

              //         final agentName = agentData["name"];
              //         return Text(agentName.toString());
              //       } else {
              //         return const Text("Not Found");
              //       }
              //     },
              //   ),
              // ),

              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: FirebaseDatabaseServices().getUserDetails(customerId),
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            Lottie.asset("assets/loading.json", repeat: true),
                      );
                    }
                    if (snap.hasData) {
                      final userData =
                          snap.data!.data() as Map<String, dynamic>;

                      final userName = userData["name"];
                      return Text(userName.toString());
                    } else {
                      return const Text("Not Found");
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(amount, style: AppStyles.subtitleText),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  status,
                  style: AppStyles.subtitleText,
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  platform,
                  style: AppStyles.subtitleText,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  createdDate,
                  style: AppStyles.subtitleText,
                ),
              ),
              // Expanded(
              //   child: TextButton(
              //     onPressed: () {
              //       Clipboard.setData(ClipboardData(text: meetingLink));
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text('Meeting link copied')),
              //       );
              //     },
              //     child: Text(meetingLink ?? "Null"),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }

  Widget reusableRowHeadlineWidget(
    serialNum,
    // agentName,
    customerName,
    amount,
    status,
    platform,
    created,
  ) {
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
            child: Text(serialNum,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(agentName,
          //       style: AppStyles.subtitleText
          //           .copyWith(fontSize: 20, color: Colors.black)),
          // ),
          Expanded(
            flex: 1,
            child: Text(
              customerName,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              amount,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              status,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              platform,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              created,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     meetingLink,
          //     style: AppStyles.subtitleText
          //         .copyWith(fontSize: 20, color: Colors.black),
          //   ),
          // ),
        ],
      ),
    );
  }
}
