import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/controllers/sermon_controller.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:telugu_bible/widgets/add_sermon_note_widget.dart';
import 'package:telugu_bible/widgets/edit_sermon_page.dart';

import '../utis/colors.dart';

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
            appBar: AppBar(
              title: const Text("Sermon Lists"),
              elevation: 0,
            ),
            body: Column(
              children: [
                SizedBox(height: AppDimensionHelper.getHt(5)),
                ElevatedButton(
                    onPressed: () => Get.to(() => const AddNewSermonPage()),
                    child: const Text("Add New Sermon")),
                SizedBox(height: AppDimensionHelper.getHt(5)),
                const Divider(),
                SizedBox(height: AppDimensionHelper.getHt(10)),
                StreamBuilder<QuerySnapshot>(
                  stream: controller.firebaseServices.sermonNotes
                      .where("userId",
                          isEqualTo: controller.auth.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<QueryDocumentSnapshot> sermonDocs =
                          snapshot.data!.docs;
                      return sermonDocs.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: sermonDocs.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (ctx, index) {
                                  final sermonData = sermonDocs[index];
                                  final title = sermonData["title"];
                                  final speaker = sermonData["speaker"];
                                  final place = sermonData["place"];
                                  final reference = sermonData["reference"];
                                  final date = sermonData["date"];
                                  final documentId = sermonData.id;
                                  return Container(
                                      padding: EdgeInsets.all(
                                          AppDimensionHelper.getHt(12)),
                                      margin: EdgeInsets.all(
                                          AppDimensionHelper.getHt(10)),
                                      height: 60,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              AppDimensionHelper.getHt(8)),
                                          topRight: Radius.circular(
                                              AppDimensionHelper.getHt(8)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //first section
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("$title",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Text("Speaker: $speaker",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          //second section
                                          Text("Date : $date",
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          IconButton(
                                              onPressed: () => Get.to(
                                                    () => EditSermonDataWidget(
                                                      id: documentId,
                                                      place: place,
                                                      speaker: speaker,
                                                      title: title,
                                                      reference: reference,
                                                    ),
                                                  ),
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.white)),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text('Delete'),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        Text(
                                                            "Are you sure you want to delete the data")
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Close'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          sermonController
                                                              .deleteData(
                                                                  documentId);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Yes'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.white)),
                                        ],
                                      ));
                                },
                              ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
