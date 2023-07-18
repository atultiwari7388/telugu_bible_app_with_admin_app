import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:telugu_bible/widgets/custom_square_button_widget.dart';
import '../controllers/sermon_controller.dart';
import '../utis/app_style.dart';
import '../utis/snack_bar_msg.dart';

class EditSermonDataWidget extends StatefulWidget {
  const EditSermonDataWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.speaker,
    required this.place,
    required this.date,
    required this.time,
  }) : super(key: key);

  final String id;
  final String title;
  final String speaker;
  final String place;
  final String date;
  final String time;

  @override
  State<EditSermonDataWidget> createState() => _EditSermonDataWidgetState();
}

class _EditSermonDataWidgetState extends State<EditSermonDataWidget> {
  final sermonController = Get.put(SermonController());
  late TextEditingController referenceController;
  late TextEditingController notesController;
  List<String> referenceData = [];
  List<String> notesData = [];

  @override
  void initState() {
    super.initState();
    referenceController = TextEditingController();
    notesController = TextEditingController();
    // fetchReferenceData();
    // fetchNotesData();
  }

  @override
  void dispose() {
    referenceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void saveReferenceData() {
    final updatedData = {
      'reference': referenceController.text,
      'updated_at': DateTime.now(),
    };
    sermonController.editData(widget.id, updatedData);
    // showSnackBarMessage('Success', 'Sermon data saved', Colors.green);
  }

  void saveNotesData() {
    final updatedData = {
      'notes': notesController.text,
      'updated_at': DateTime.now(),
    };
    sermonController.editData(widget.id, updatedData);
    // showSnackBarMessage('Success', 'Sermon data saved', Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Sermons'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopSection(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomSquareButtonWidget(
                    text: 'Add Reference',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add Reference'),
                          content: TextField(
                            controller: referenceController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                saveReferenceData();
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'Enter\nfirst 3 letters of the block+\nChapter Number+\nReference Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  CustomSquareButtonWidget(
                    text: 'Add Notes',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Add Notes'),
                          content: TextField(
                            controller: notesController,
                            decoration: const InputDecoration(
                              labelText: 'Notes',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                saveNotesData();
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              StreamBuilder<QuerySnapshot>(
                stream: sermonController.firebaseServices.sermonNotes
                    .where("userId",
                        isEqualTo: sermonController.auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<QueryDocumentSnapshot> sermonDocs =
                        snapshot.data!.docs;
                    return sermonDocs.isNotEmpty
                        ? ListView.builder(
                            itemCount: sermonDocs.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              final sermonData = sermonDocs[index];
                              final reference = sermonData["reference"] ?? "";
                              final notes = sermonData["notes"] ?? "";

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Reference : $reference"),
                                  Text("Note : $notes"),
                                ],
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
              )
              // const Text('References:',
              //     style: TextStyle(fontWeight: FontWeight.bold)),
              // Column(
              //   children:
              //       referenceData.map((reference) => Text(reference)).toList(),
              // ),
              // const SizedBox(height: 10),
              // const Text('Notes:',
              //     style: TextStyle(fontWeight: FontWeight.bold)),
              // Column(
              //   children: notesData.map((note) => Text(note)).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopSection() {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.kLightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Date: ${widget.date}'),
              Text('Time: ${widget.time}'),
              Text('Speaker: ${widget.speaker}'),
            ],
          ),
          const SizedBox(height: 10),
          Text('Title of the Sermon: ${widget.title}'),
        ],
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:telugu_bible/helper/dimension_helper.dart';
// import 'package:telugu_bible/utis/colors.dart';
// import 'package:telugu_bible/widgets/custom_square_button_widget.dart';
// import '../controllers/sermon_controller.dart';

// class EditSermonDataWidget extends StatefulWidget {
//   const EditSermonDataWidget({
//     Key? key,
//     required this.id,
//     required this.title,
//     required this.speaker,
//     required this.place,
//     required this.date,
//     required this.time,
//   }) : super(key: key);

//   final String id;
//   final String title;
//   final String speaker;
//   final String place;
//   final String date, time;

//   @override
//   State<EditSermonDataWidget> createState() => _EditSermonDataWidgetState();
// }

// class _EditSermonDataWidgetState extends State<EditSermonDataWidget> {
//   final sermonController = Get.put(SermonController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Sermons"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTopSection(),
//               SizedBox(height: AppDimensionHelper.getHt(10)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CustomSquareButtonWidget(text: "Add Reference", onTap: () {}),
//                   Container(
//                       height: AppDimensionHelper.getHt(70),
//                       width: AppDimensionHelper.getWd(150),
//                       decoration: BoxDecoration(
//                           color: AppColors.kPrimaryColor,
//                           borderRadius: BorderRadius.circular(6)),
//                       child: const Center(
//                           child: Text(
//                               "Enter\n first 3 letter of the block+\nspace +Chapter Number+\nspace+reference number ",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 12)))),
//                   CustomSquareButtonWidget(text: "Add Notes", onTap: () {}),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// //========================== Build Top Section ================================
//   Widget buildTopSection() {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       margin: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: AppColors.kLightColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Date : ${widget.date}"),
//               Text("Time : ${widget.time}"),
//               Text("Speaker : ${widget.speaker}"),
//             ],
//           ),
//           SizedBox(height: AppDimensionHelper.getHt(10)),
//           Text("Title of the Sermon : ${widget.title}")
//         ],
//       ),
//     );
//   }
// }



















 // late TextEditingController titleController;
  // late TextEditingController speakerController;
  // late TextEditingController placeController;

  // @override
  // void initState() {
  //   super.initState();
  //   titleController = TextEditingController(text: widget.title);
  //   speakerController = TextEditingController(text: widget.speaker);
  //   placeController = TextEditingController(text: widget.place);
  // }

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   speakerController.dispose();
  //   placeController.dispose();
  //   super.dispose();
  // }
