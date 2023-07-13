import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

class AddDailyQuotes extends StatefulWidget {
  static const String id = "admin-add-quote";

  const AddDailyQuotes({Key? key}) : super(key: key);

  @override
  State<AddDailyQuotes> createState() => _AddDailyQuotesState();
}

class _AddDailyQuotesState extends State<AddDailyQuotes> {
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
              Text("Daily Quotes", style: AppStyles.headlineText),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => buildAddDataFunction(),
                child: Text(
                  "Add More",
                  style: AppStyles.subtitleText.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 50),
          reusableRowHeadlineWidget("#", "Title", "Quotes", "Action"),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseDatabaseServices()
                .dailyQuotesCollection
                .orderBy("created_at", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/loading.json", repeat: true),
                );
              }
              if (snapshot.hasData) {
                final List<QueryDocumentSnapshot> dailyQuotesData =
                    snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dailyQuotesData.length,
                  itemBuilder: (ctx, index) {
                    final quotesData = dailyQuotesData[index];
                    final serialNumber = index + 1;
                    final quoteTitle = quotesData["name"];
                    final documentId = quotesData.id;
                    final quoteData = quotesData["quote"];

                    return reusableRowWidget(
                      serialNumber.toString(),
                      quoteTitle,
                      quoteData,
                      documentId,
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Text('Error Data not Found ');
              } else {
                return const Text('Error Data not Found ');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget reusableRowWidget(srNumb, title, quote, id) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1, child: Text(srNumb, style: AppStyles.subtitleText)),
              Expanded(
                  flex: 1, child: Text(title, style: AppStyles.subtitleText)),
              Expanded(
                  flex: 1, child: Text(quote, style: AppStyles.subtitleText)),
              Expanded(
                child: ElevatedButton.icon(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      buildDeleteDataWidget(id);
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text("Delete")),
              ),
            ],
          ),
        ],
      ),
    );
  }

//===================  Delete Data =======================

  Future buildDeleteDataWidget(faqId) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure you want to Delete."),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No",
                style: AppStyles.subtitleText
                    .copyWith(color: AppColors.kRedColor)),
          ),
          TextButton(
            onPressed: () {
              FirebaseDatabaseServices().deleteQuoteDataUsingID(faqId);
              Navigator.pop(context);
            },
            child: Text("Yes",
                style: AppStyles.subtitleText.copyWith(color: Colors.green)),
          ),
        ],
      ),
    );
  }

//================= Add data  ====================================

  Future buildAddDataFunction() {
    final TextEditingController newTitleController = TextEditingController();
    final TextEditingController quotesController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add New Quote"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text input for title
                  TextField(
                    controller: newTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text input for description
                  TextField(
                    maxLines: 1,
                    controller: quotesController,
                    decoration: const InputDecoration(
                      labelText: "Quotes of the day",
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    // Call the addData functionality
                    FirebaseDatabaseServices().addQuotesData({
                      "created_at": DateTime.now(),
                      "name": newTitleController.text.toString(),
                      "quote": quotesController.text.toString(),
                      "updated_at": DateTime.now(),
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget reusableRowHeadlineWidget(text1, text2, text3, text4) {
    return Container(
      padding:
          const EdgeInsets.only(top: 18.0, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: Text(text3,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
          Expanded(
            flex: 1,
            child: Text(text4,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
