import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

class AdminEnglishBibleScreen extends StatefulWidget {
  static const String id = "admin-englishBible";

  const AdminEnglishBibleScreen({Key? key}) : super(key: key);

  @override
  State<AdminEnglishBibleScreen> createState() =>
      _AdminEnglishBibleScreenState();
}

class _AdminEnglishBibleScreenState extends State<AdminEnglishBibleScreen> {
  // String? newSelectedPlatform;
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
              Text("English Bible", style: AppStyles.headlineText),
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
          reusableRowHeadlineWidget(
              "#", "Heading", "Chapter", "Content", "Actions"),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseDatabaseServices()
                .englishBibleCollection
                .orderBy("created_at", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/loading.json", repeat: true),
                );
              }
              if (snapshot.hasData) {
                final List<QueryDocumentSnapshot> holyDocs =
                    snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: holyDocs.length,
                  itemBuilder: (ctx, index) {
                    final holyData = holyDocs[index];
                    final serialNumber = index + 1;

                    final chapterName = holyData["chapterName"];
                    final headingName = holyData["heading"];
                    final dataList = List.from(holyData['dataList']);

                    final documentId = holyData.id;

                    return reusableRowWidget(
                      serialNumber.toString(),
                      headingName,
                      chapterName,
                      dataList,
                      documentId,
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Text('Error Data Not Found');
              } else {
                return const Text('Error Data Not Found');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget reusableRowWidget(
      text1, headingName, chapterName, List<dynamic> dataList, holyId) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1, child: Text(text1, style: AppStyles.subtitleText)),
              Expanded(
                  flex: 1,
                  child: Text(headingName, style: AppStyles.subtitleText)),
              Expanded(
                  flex: 1,
                  child: Text(chapterName, style: AppStyles.subtitleText)),
              Expanded(
                child: ListTile(
                  // leading: Text(headingName),
                  // title: Text(chapterName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dataList.map((item) {
                      return Text(item);
                    }).toList(),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(),
                    // ElevatedButton.icon(
                    //     style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.green),
                    //     onPressed: () {
                    //       //firebase data
                    //       // buildEditDataWidget(title, description, holyId);
                    //     },
                    //     icon: const Icon(Icons.edit, color: Colors.white),
                    //     label: const Text("Edit")),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          buildDeleteDataWidget(holyId);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text("Delete")),
                  ],
                ),
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
        title: const Text("Holy Bible Delete"),
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
              FirebaseDatabaseServices().deleteEnglishBibleDataUsingID(faqId);
              Navigator.pop(context);
            },
            child: Text("Yes",
                style: AppStyles.subtitleText.copyWith(color: Colors.green)),
          ),
        ],
      ),
    );
  }

//=================  Edit Data ===========================
  Future buildEditDataWidget(title, description, holyId) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController descriptionController =
        TextEditingController(text: description);

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("Update Data"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // put for title
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Text input for title
                    TextField(
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      // Call the update functionality
                      FirebaseDatabaseServices().editDataUsingId(holyId, {
                        "name": titleController.text.toString(),
                        "description": descriptionController.text.toString(),
                        "updated_at": DateTime.now()
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              );
            },
          );
        });
  }

//================= Add data  ====================================

  Future buildAddDataFunction() {
    List<String> dataList = [];
    TextEditingController topHeadinController = TextEditingController();
    TextEditingController chapterNameController = TextEditingController();
    TextEditingController dataController = TextEditingController();

    void addData() {
      setState(() {
        String data = dataController.text;
        dataList.add(data);
        dataController.clear();
      });
    }

    Future<void> submitData() async {
      FirebaseDatabaseServices().addEnglishBibleData({
        "heading": topHeadinController.text,
        'chapterName': chapterNameController.text,
        'dataList': dataList,
        "created_at": DateTime.now(),
        "updated_at": DateTime.now(),
      });

      log('Data stored successfully. Document ID:');
    }

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Enter New Data"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Heading Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: topHeadinController,
                          decoration: const InputDecoration(
                            hintText: 'Enter top heading name',
                          ),
                        ),
                        const Text(
                          'Chapter Name:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: chapterNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter chapter name',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'List of Data:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: dataController,
                          decoration: const InputDecoration(
                            hintText: 'Enter data',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: addData,
                          child: const Text('Add Data'),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          '*If you Insert first data then click addData after that insert second data then click addData \nAfter completing those addData then click submit button.*',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      submitData();
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget reusableRowHeadlineWidget(text1, text2, text3, text4, text5) {
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
          Expanded(
            flex: 1,
            child: Text(text5,
                style: AppStyles.subtitleText
                    .copyWith(fontSize: 20, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
