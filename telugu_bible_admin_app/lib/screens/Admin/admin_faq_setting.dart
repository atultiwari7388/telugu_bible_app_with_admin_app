import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';

class AdminFAQScreen extends StatefulWidget {
  static const String id = "admin-faq";

  const AdminFAQScreen({Key? key}) : super(key: key);

  @override
  State<AdminFAQScreen> createState() => _AdminFAQScreenState();
}

class _AdminFAQScreenState extends State<AdminFAQScreen> {
  String? newSelectedPlatform;
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
              Text("Faq", style: AppStyles.headlineText),
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
          reusableRowHeadlineWidget("#", "Platform", "Title", "Action"),
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseDatabaseServices()
                .holyBibleCollection
                .orderBy("created_at", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/loading.json", repeat: true),
                );
              }
              if (snapshot.hasData) {
                final List<QueryDocumentSnapshot> faqDocs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqDocs.length,
                  itemBuilder: (ctx, index) {
                    final faq = faqDocs[index];
                    final serialNumber = index + 1;
                    final platformName = faq["platform_name"];
                    final platformTitle = faq["name"];
                    final documentId = faq.id;
                    final selectedPlatform = faq["platform_name"];
                    final description = faq["description"];
                    final platformId = faq["platform_id"];

                    return reusableRowWidget(
                      serialNumber.toString(),
                      platformName,
                      platformTitle,
                      "Action",
                      documentId,
                      selectedPlatform,
                      description,
                      platformId,
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
    );
  }

  Widget reusableRowWidget(text1, text2, text3, text4, faqId, selectedPlatform,
      description, platformId) {
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
                  flex: 1, child: Text(text2, style: AppStyles.subtitleText)),
              Expanded(
                  flex: 1, child: Text(text3, style: AppStyles.subtitleText)),
              Expanded(
                child: Row(
                  children: [
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          //firebase data
                          buildEditDataWidget(selectedPlatform, faqId,
                              description, text3, platformId);
                        },
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text("Edit")),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          buildDeleteDataWidget(faqId);
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
        title: const Text("Faq Delete"),
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
              FirebaseDatabaseServices().deleteDataUsingID(faqId);
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
  Future buildEditDataWidget(
      selectedPlatform, faqId, description, text3, platformId) {
    final TextEditingController titleController =
        TextEditingController(text: text3);
    final TextEditingController descriptionController =
        TextEditingController(text: description);

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseDatabaseServices().platforms.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Lottie.asset("assets/loading.json", repeat: true),
                );
              }
              if (snapshot.hasError) {
                return const Text('Error fetching platforms');
              }
              final List<QueryDocumentSnapshot> platformDocs =
                  snapshot.data!.docs;
              final List<String> platformOptions =
                  platformDocs.map((doc) => doc['name'] as String).toList();
              final List<String> platformIds =
                  platformDocs.map((doc) => doc.id).toList();

              return AlertDialog(
                title: const Text("Update Data"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dropdown for platform selection
                    DropdownButton<String>(
                      value: selectedPlatform,
                      items: platformOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedPlatform = item;
                          int index = platformOptions.indexOf(selectedPlatform);
                          platformId = platformIds[index];
                        });
                      },
                    ),

                    // Text input for title
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
                      FirebaseDatabaseServices().editDataUsingId(faqId, {
                        "platform_name": selectedPlatform,
                        "name": titleController.text.toString(),
                        "description": descriptionController.text.toString(),
                        "platform_id": platformId,
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
      },
    );
  }

//================= Add data  ====================================

  Future buildAddDataFunction() {
    final TextEditingController newTitleController = TextEditingController();
    final TextEditingController newDescriptionController =
        TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FutureBuilder<QuerySnapshot>(
              future: FirebaseDatabaseServices().platforms.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset("assets/loading.json", repeat: true),
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Error fetching platforms');
                }
                // final List<QueryDocumentSnapshot> platformDocs =
                //     snapshot.data!.docs;
                // final List<String> platformOptions =
                //     platformDocs.map((doc) => doc['name'] as String).toList();
                // final List<String> platformIds =
                //     platformDocs.map((doc) => doc.id).toList();

                // // Set the initial value for newSelectedPlatform
                // newSelectedPlatform =
                //     platformOptions.isNotEmpty ? platformOptions[0] : '';
                final List<QueryDocumentSnapshot> platformDocs =
                    snapshot.data!.docs;
                final List<String> platformOptions =
                    platformDocs.map((doc) => doc['name'] as String).toList();
                final List<String> platformIds =
                    platformDocs.map((doc) => doc.id).toList();

                if (newSelectedPlatform == null && platformOptions.isNotEmpty) {
                  // Set the initial value for newSelectedPlatform
                  newSelectedPlatform = platformOptions[0];
                }

                return AlertDialog(
                  title: const Text("Update Data"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dropdown for platform selection
                      DropdownButton<String>(
                        value: newSelectedPlatform,
                        items: platformOptions.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (item) {
                          setState(() {
                            newSelectedPlatform = item!;
                          });
                        },
                      ),

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
                        controller: newDescriptionController,
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        // Get the selected platform index
                        int selectedPlatformIndex =
                            platformOptions.indexOf(newSelectedPlatform!);

                        // Get the corresponding platform ID
                        String selectedPlatformId =
                            platformIds[selectedPlatformIndex];

                        // Call the addData functionality
                        FirebaseDatabaseServices().addData({
                          "created_at": DateTime.now(),
                          "description":
                              newDescriptionController.text.toString(),
                          "name": newTitleController.text.toString(),
                          "platform_name": newSelectedPlatform.toString(),
                          "platform_id": selectedPlatformId,
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
