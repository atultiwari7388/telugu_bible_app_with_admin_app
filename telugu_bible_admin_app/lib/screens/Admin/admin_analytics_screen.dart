import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/screens/Admin/widgets/admin_analysis_box.widget.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

import '../../constants/utils/colors.utils.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  static const String id = "dashboard";

  const AdminAnalyticsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  String formatDateWithTimeStamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

  Widget buildAnalysisBox({
    required Stream<QuerySnapshot> stream,
    required String firstText,
    required IconData icon,
    Color containerColor = AppColors.kPrimaryColor,
    required onTap,
  }) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Lottie.asset("assets/loading.json", repeat: false);
        } else if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data!.docs;
          int count = documents.length;

          return InkWell(
            onTap: onTap,
            child: AdminAnalysisBoxesWidgets(
              containerColor: containerColor,
              firstText: firstText,
              secondText: count.toString(),
              icon: icon,
            ),
          );
        } else {
          return Container(); // Placeholder widget for error or no data
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 3.5,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            shrinkWrap: true,
            padding: const EdgeInsets.all(2),
            children: [
              //Total Appointments
              buildAnalysisBox(
                onTap: () {},
                // onTap: () => Get.to(() => const DashboardAppointmentsData()),
                stream: FirebaseDatabaseServices().totalBooks,
                firstText: "Total Books",
                icon: FontAwesomeIcons.book,
              ),

              //total Agents
              buildAnalysisBox(
                onTap: () {},
                // onTap: () => Get.to(() => const DashboardTotalAgentsData()),
                stream: FirebaseDatabaseServices().totalSermonNotes,
                firstText: "Total SermonNotes",
                icon: FontAwesomeIcons.noteSticky,
                containerColor: Colors.green,
              ),
              //total Customers
              buildAnalysisBox(
                onTap: () {},
                // onTap: () => Get.to(() => const DashboardCustomersData()),
                stream: FirebaseDatabaseServices().customersList,
                firstText: "Total Users",
                icon: FontAwesomeIcons.users,
                containerColor: Colors.red,
              )
            ],
          ),
          const SizedBox(height: 20),

          //Appointments section
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("New Users", style: AppStyles.headlineText),
                  ],
                ),
                const SizedBox(height: 30),
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
                        child:
                            Lottie.asset("assets/loading.json", repeat: true),
                      );
                    }

                    if (snapshot.hasData) {
                      final List<DocumentSnapshot> customerDocs =
                          snapshot.data!.docs;
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
                      return const Text('Error fetching FAQs');
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
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
                  radius: 40,
                  child: Image.network(photo),
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
