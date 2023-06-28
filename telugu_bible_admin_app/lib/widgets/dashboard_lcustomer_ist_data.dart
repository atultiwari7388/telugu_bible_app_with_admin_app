import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

import '../constants/utils/colors.utils.dart';

class DashboardCustomersData extends StatefulWidget {
  const DashboardCustomersData({Key? key}) : super(key: key);

  @override
  _DashboardCustomersDataState createState() => _DashboardCustomersDataState();
}

class _DashboardCustomersDataState extends State<DashboardCustomersData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Customers"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableRowHeadlineWidget(
                  "#", "Name", "Email", "Phone", "Permission", "Details"),
              const SizedBox(height: 10),
              FutureBuilder(
                future: FirebaseDatabaseServices()
                    .customerLists
                    .where("role", isEqualTo: 0)
                    .orderBy("created_at", descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset("assets/loading.json", repeat: true),
                    );
                  }
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> customerDocs =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: customerDocs.length,
                      itemBuilder: (ctx, index) {
                        final customer = customerDocs[index];
                        final serialNumber = index + 1;
                        final customerName = customer["name"];
                        final customerEmail = customer["email"];
                        final customerPhone = customer["phone"];
                        // final permission = [""];

                        return reusableRowWidget(
                            serialNumber.toString(),
                            customerName,
                            customerEmail,
                            customerPhone,
                            "permission",
                            "Details");
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

  Widget reusableRowWidget(text1, text2, text3, text4, text5, text6) {
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
                child: Text(text2, style: AppStyles.subtitleText),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  text3,
                  style: AppStyles.subtitleText,
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  text4,
                  textAlign: TextAlign.center,
                  style: AppStyles.subtitleText,
                ),
              ),
              Expanded(
                flex: 1,
                child: Switch(
                  activeColor: Colors.green,
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor),
                  onPressed: () {},
                  child: Text("Details"),
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

  Widget reusableRowHeadlineWidget(text1, text2, text3, text4, text5, text6) {
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
          Expanded(
            flex: 1,
            child: Text(
              text6,
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
