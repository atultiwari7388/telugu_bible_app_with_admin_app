import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/controllers/sermon_controller.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:telugu_bible/utis/colors.dart';

class SermonNotesScreen extends StatefulWidget {
  const SermonNotesScreen({Key? key}) : super(key: key);

  @override
  State<SermonNotesScreen> createState() => _SermonNotesScreenState();
}

class _SermonNotesScreenState extends State<SermonNotesScreen> {
  final sermonController = Get.put(SermonController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SermonController>(
        builder: (controller) {
          return Scaffold(
            // backgroundColor: AppColors.kLightGreyColor,
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              title: const Text("Sermon Lists"),
              elevation: 0,
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: controller.firebaseServices.sermonNotes
                  .where("userId", isEqualTo: controller.auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> sermonDocs =
                      snapshot.data!.docs;
                  return sermonDocs.isNotEmpty
                      ? ListView.builder(
                          itemCount: sermonDocs.length,
                          itemBuilder: (ctx, index) {
                            final sermonData = sermonDocs[index];
                            final title = sermonData["title"];
                            final speaker = sermonData["speaker"];
                            final place = sermonData["place"];
                            return Container(
                              padding:
                                  EdgeInsets.all(AppDimensionHelper.getHt(12)),
                              margin:
                                  EdgeInsets.all(AppDimensionHelper.getHt(10)),
                              // height: 120,
                              width: double.maxFinite,
                              // decoration: BoxDecoration(
                              //   color: AppColors.kWhiteColor,
                              //   borderRadius: BorderRadius.only(
                              //     bottomLeft: Radius.circular(
                              //         AppDimensionHelper.getHt(20)),
                              //     topRight: Radius.circular(
                              //         AppDimensionHelper.getHt(20)),
                              //   ),
                              // ),
                              child: Text("${index + 1}. " + title,
                                  style: AppFontStyles.MediumHeadingText),
                            );
                          },
                        )
                      : const Center(child: Text('No Data Found ?'));
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("No Data Available",
                        style: AppFontStyles.MediumHeadingText),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Text("Something went wrong");
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text("Add Data"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text input for title
                          TextField(
                            controller: controller.titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                          SizedBox(height: AppDimensionHelper.getHt(10)),
                          // Text input for description
                          TextField(
                            maxLines: 1,
                            controller: controller.placeController,
                            decoration: const InputDecoration(
                              labelText: "Place",
                            ),
                          ),
                          SizedBox(height: AppDimensionHelper.getHt(10)),
                          // Text input for description
                          TextField(
                            maxLines: 1,
                            controller: controller.speakerController,
                            decoration: const InputDecoration(
                              labelText: "Speaker",
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            controller.addSermonNotes();
                            Navigator.pop(context);
                          },
                          child: const Text("Submit"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
