import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

import '../constants/utils/styles.utils.dart';

class DashboardAppointmentsData extends StatefulWidget {
  const DashboardAppointmentsData({Key? key}) : super(key: key);

  @override
  _DashboardAppointmentsDataState createState() =>
      _DashboardAppointmentsDataState();
}

class _DashboardAppointmentsDataState extends State<DashboardAppointmentsData> {
  String formatDateWithTimeStamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Appointments"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableRowHeadlineWidget(
                "#",
                "A-Name",
                "C-Name",
                "Charges",
                "Platform",
                // "Timing",
                // "Meeting Link",
                // "Status",
                "Created",
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: FirebaseDatabaseServices()
                    .appointments
                    .orderBy("created_at", descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset("assets/loading.json", repeat: true),
                    );
                  }
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> appointmentDocs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: appointmentDocs.length,
                      itemBuilder: (ctx, index) {
                        final appointment = appointmentDocs[index];
                        final serialNumber = index + 1;
                        final amount = appointment["amount"] ?? "";
                        // final status = appointment["payment_status"] ?? "";
                        final platform = appointment["platform"] ?? "";
                        // final meetingLink = appointment["meeting_link"] ?? "";
                        // final timing = appointment["date"] ?? "";
                        final createdAtTiming = appointment["created_at"];
                        final agentId = appointment["agent_id"];
                        final userId = appointment["user_id"];
                        // final formatedTime = formatDateWithTimeStamp(timing);
                        final formatedCreateTiming =
                            formatDateWithTimeStamp(createdAtTiming);
                        final finalAmount = amount.substring(0, 2);

                        return reusableRowWidget(
                          serialNumber.toString(),
                          agentId,
                          userId,
                          "\$$finalAmount",
                          platform,
                          // formatedTime,
                          // meetingLink.toString(),
                          // status,
                          formatedCreateTiming,
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Error fetching FAQs');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reusableRowWidget(
    text1,
    agentId,
    userId,
    charges,
    platform,
    // meetingLink,
    created,
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
                child: FutureBuilder(
                  future: FirebaseDatabaseServices().getUserDetails(agentId),
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            Lottie.asset("assets/loading.json", repeat: true),
                      ); // Show a loading indicator while fetching data
                    }

                    if (snap.hasData) {
                      final agentData =
                          snap.data!.data() as Map<String, dynamic>;

                      final agentName = agentData["name"];
                      return Text(agentName.toString());
                    } else {
                      return const Text("Not Found");
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: FirebaseDatabaseServices().getUserDetails(userId),
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
                child: Text(
                  charges,
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleText,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  platform,
                  textAlign: TextAlign.center,
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
              //     child: Text(meetingLink),
              //   ),
              // ),
              Expanded(
                flex: 1,
                child: Text(
                  created,
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

  Widget reusableRowHeadlineWidget(
    text1,
    text2,
    text3,
    text4,
    text5,
    // text7,
    text9,
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
            child: Text(text1,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text(text2,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text3,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text4,
              textAlign: TextAlign.center,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              text5,
              textAlign: TextAlign.center,
              style: AppStyles.subtitleText
                  .copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     text7,
          //     textAlign: TextAlign.center,
          //     style: AppStyles.subtitleText
          //         .copyWith(fontSize: 20, color: Colors.black),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Text(
              text9,
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
