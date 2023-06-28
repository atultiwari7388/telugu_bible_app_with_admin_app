import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/services/firebase_services.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class HolyBibleScreen extends StatefulWidget {
  const HolyBibleScreen({Key? key}) : super(key: key);

  @override
  State<HolyBibleScreen> createState() => _HolyBibleScreenState();
}

class _HolyBibleScreenState extends State<HolyBibleScreen> {
  final firebaseServices = FirebaseServices();
  int currentChapterIndex = 0;
  late String selectedChapterName = '';
  late List<String> selectedChapterDataList = [];
  late String headingName = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final snapshot = await firebaseServices.holyBible
        .orderBy("created_at", descending: false)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final holyData = snapshot.docs[currentChapterIndex];
      setState(() {
        headingName = holyData["heading"];
        selectedChapterName = holyData["chapterName"] ?? '';
        selectedChapterDataList = List<String>.from(holyData['dataList']);
      });
    } else {
      setState(() {
        headingName = "";
        selectedChapterName = "";
        selectedChapterDataList = [];
      });
    }
  }

  void updateChapter(int index) {
    final snapshot = firebaseServices.holyBible
        .orderBy("created_at", descending: false)
        .snapshots()
        .asBroadcastStream();

    snapshot.listen((querySnapshot) {
      final holyData = querySnapshot.docs[index];
      setState(() {
        currentChapterIndex = index;
        selectedChapterName = holyData["chapterName"] ?? '';
        selectedChapterDataList = List<String>.from(holyData['dataList']);
      });
    });
  }

  void showCopyShareDialog(String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Navigator.pop(context);
                  copyDataToClipboard(data);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  Navigator.pop(context);
                  shareData(data);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void copyDataToClipboard(String data) {
    Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data copied to clipboard')),
    );
  }

  void shareData(String data) {
    Share.share(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Holy Bible"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (selectedChapterName.isNotEmpty &&
                selectedChapterDataList.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: AppDimensionHelper.getHt(10)),
                  ListTile(
                    title: Center(
                      child: Text(
                        headingName,
                        style: AppFontStyles.MediumHeadingText.copyWith(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimensionHelper.getHt(20)),
                  ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 25),
                          onPressed: () {
                            if (currentChapterIndex > 0) {
                              updateChapter(currentChapterIndex - 1);
                            }
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // Handle chapter tap if needed
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedChapterName,
                                  style: AppFontStyles.smallText.copyWith(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 25),
                          onPressed: () {
                            if (currentChapterIndex <
                                selectedChapterDataList.length - 1) {
                              updateChapter(currentChapterIndex + 1);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensionHelper.getHt(30)),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedChapterDataList.length,
                    itemBuilder: (context, index) {
                      final data = selectedChapterDataList[index];
                      return ListTile(
                        contentPadding:
                            EdgeInsets.all(AppDimensionHelper.getHt(10)),
                        title: GestureDetector(
                          onTap: () {
                            showCopyShareDialog(data);
                          },
                          child: Text(
                            data,
                            textAlign: TextAlign.justify,
                            style: AppFontStyles.smallText.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            if (selectedChapterName.isEmpty || selectedChapterDataList.isEmpty)
              Center(
                child: Lottie.asset("assets/loading.json", repeat: true),
              ),
            if (selectedChapterName.isNotEmpty &&
                selectedChapterDataList.isEmpty)
              const Center(
                child: Text("No Data Available"),
              ),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_bible/helper/dimension_helper.dart';
// import 'package:telugu_bible/services/firebase_services.dart';
// import 'package:telugu_bible/utis/app_style.dart';
// import 'package:flutter/services.dart';

// class HolyBibleScreen extends StatefulWidget {
//   const HolyBibleScreen({Key? key}) : super(key: key);

//   @override
//   State<HolyBibleScreen> createState() => _HolyBibleScreenState();
// }

// class _HolyBibleScreenState extends State<HolyBibleScreen> {
//   final firebaseServices = FirebaseServices();
//   int currentChapterIndex = 0;
//   late String selectedChapterName = '';
//   late List<String> selectedChapterDataList = [];
//   late String headingName = "";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final snapshot = await firebaseServices.holyBible
//         .orderBy("created_at", descending: false)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       final holyData = snapshot.docs[currentChapterIndex];
//       setState(() {
//         headingName = holyData["heading"];
//         selectedChapterName = holyData["chapterName"] ?? '';
//         selectedChapterDataList = List<String>.from(holyData['dataList']);
//       });
//     } else {
//       setState(() {
//         headingName = "";
//         selectedChapterName = "";
//         selectedChapterDataList = [];
//       });
//     }
//   }

//   void updateChapter(int index) {
//     final snapshot = firebaseServices.holyBible
//         .orderBy("created_at", descending: false)
//         .snapshots()
//         .asBroadcastStream();

//     snapshot.listen((querySnapshot) {
//       final holyData = querySnapshot.docs[index];
//       setState(() {
//         currentChapterIndex = index;
//         selectedChapterName = holyData["chapterName"] ?? '';
//         selectedChapterDataList = List<String>.from(holyData['dataList']);
//       });
//     });
//   }

//   void copyDataToClipboard(String data) {
//     Clipboard.setData(ClipboardData(text: data));
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Data copied to clipboard')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Holy Bible"),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if (selectedChapterName.isNotEmpty &&
//                 selectedChapterDataList.isNotEmpty)
//               Column(
//                 children: [
//                   SizedBox(height: AppDimensionHelper.getHt(10)),
//                   ListTile(
//                     title: Center(
//                       child: Text(
//                         headingName,
//                         style: AppFontStyles.MediumHeadingText.copyWith(
//                           fontSize: 25,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: AppDimensionHelper.getHt(20)),
//                   ListTile(
//                     title: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios, size: 25),
//                           onPressed: () {
//                             if (currentChapterIndex > 0) {
//                               updateChapter(currentChapterIndex - 1);
//                             }
//                           },
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               // Handle chapter tap if needed
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   selectedChapterName,
//                                   style: AppFontStyles.smallText.copyWith(
//                                     fontSize: 25,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward_ios, size: 25),
//                           onPressed: () {
//                             if (currentChapterIndex <
//                                 selectedChapterDataList.length - 1) {
//                               updateChapter(currentChapterIndex + 1);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: AppDimensionHelper.getHt(30)),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: selectedChapterDataList.length,
//                     itemBuilder: (context, index) {
//                       final data = selectedChapterDataList[index];
//                       return ListTile(
//                         contentPadding:
//                             EdgeInsets.all(AppDimensionHelper.getHt(10)),
//                         title: GestureDetector(
//                           onTap: () {
//                             copyDataToClipboard(data);
//                           },
//                           child: Text(
//                             data,
//                             textAlign: TextAlign.justify,
//                             style: AppFontStyles.smallText.copyWith(
//                               fontSize: 20,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             if (selectedChapterName.isEmpty || selectedChapterDataList.isEmpty)
//               Center(
//                 child: Lottie.asset("assets/loading.json", repeat: true),
//               ),
//             if (selectedChapterName.isNotEmpty &&
//                 selectedChapterDataList.isEmpty)
//               const Center(
//                 child: Text("No Data Available"),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_bible/helper/dimension_helper.dart';
// import 'package:telugu_bible/services/firebase_services.dart';
// import 'package:telugu_bible/utis/app_style.dart';

// class HolyBibleScreen extends StatefulWidget {
//   const HolyBibleScreen({Key? key}) : super(key: key);

//   @override
//   State<HolyBibleScreen> createState() => _HolyBibleScreenState();
// }

// class _HolyBibleScreenState extends State<HolyBibleScreen> {
//   final firebaseServices = FirebaseServices();
//   int currentChapterIndex = 0;
//   late String selectedChapterName = '';
//   late List<String> selectedChapterDataList = [];
//   late String headingName = "";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     final snapshot = await firebaseServices.holyBible
//         .orderBy("created_at", descending: false)
//         .get();

//     if (snapshot.docs.isNotEmpty) {
//       final holyData = snapshot.docs[currentChapterIndex];
//       setState(() {
//         headingName = holyData["heading"];
//         selectedChapterName = holyData["chapterName"] ?? '';
//         selectedChapterDataList = List<String>.from(holyData['dataList']);
//       });
//     }
//   }

//   void updateChapter(int index) {
//     final snapshot = firebaseServices.holyBible
//         .orderBy("created_at", descending: false)
//         .snapshots()
//         .asBroadcastStream();

//     snapshot.listen((querySnapshot) {
//       final holyData = querySnapshot.docs[index];
//       setState(() {
//         currentChapterIndex = index;
//         selectedChapterName = holyData["chapterName"] ?? '';
//         selectedChapterDataList = List<String>.from(holyData['dataList']);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Holy Bible"),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             if (selectedChapterName.isNotEmpty &&
//                 selectedChapterDataList.isNotEmpty)
//               Column(
//                 children: [
//                   SizedBox(height: AppDimensionHelper.getHt(10)),
//                   ListTile(
//                     title: Center(
//                       child: Text(
//                         headingName,
//                         style: AppFontStyles.MediumHeadingText.copyWith(
//                             fontSize: 25),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: AppDimensionHelper.getHt(20)),
//                   ListTile(
//                     title: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.arrow_back_ios, size: 25),
//                           onPressed: () {
//                             if (currentChapterIndex > 0) {
//                               updateChapter(currentChapterIndex - 1);
//                             }
//                           },
//                         ),
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               // Handle chapter tap if needed
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   selectedChapterName,
//                                   style: AppFontStyles.smallText
//                                       .copyWith(fontSize: 25),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.arrow_forward_ios, size: 25),
//                           onPressed: () {
//                             if (currentChapterIndex <
//                                 selectedChapterDataList.length - 1) {
//                               updateChapter(currentChapterIndex + 1);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: AppDimensionHelper.getHt(30)),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.vertical,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: selectedChapterDataList.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         contentPadding:
//                             EdgeInsets.all(AppDimensionHelper.getHt(10)),
//                         title: Text(
//                           selectedChapterDataList[index],
//                           textAlign: TextAlign.justify,
//                           style: AppFontStyles.smallText.copyWith(
//                             fontSize: 20,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             if (selectedChapterName.isEmpty || selectedChapterDataList.isEmpty)
//               Center(
//                 child: Lottie.asset("assets/loading.json", repeat: true),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:telugu_bible/services/firebase_services.dart';

// class HolyBibleScreen extends StatefulWidget {
//   const HolyBibleScreen({Key? key}) : super(key: key);

//   @override
//   State<HolyBibleScreen> createState() => _HolyBibleScreenState();
// }

// class _HolyBibleScreenState extends State<HolyBibleScreen> {
//   final firebaseServices = FirebaseServices();
//   static int currentChapterIndex = 0;
//   String selectedChapterName = '';
//   List<String> selectedChapterDataList = [];

//   @override
//   void initState() {
//     super.initState();
//     currentChapterIndex = 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Holy Bible"),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             StreamBuilder<QuerySnapshot>(
//               stream: firebaseServices.holyBible
//                   .orderBy("created_at", descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Lottie.asset("assets/loading.json", repeat: true),
//                   );
//                 }
//                 if (snapshot.hasData) {
//                   final List<QueryDocumentSnapshot> holyDocs =
//                       snapshot.data!.docs;
//                   if (holyDocs.isNotEmpty) {
//                     final holyData = holyDocs[currentChapterIndex];
//                     final chapterName = holyData["chapterName"];
//                     final headingName = holyData["heading"];
//                     final dataList = List<String>.from(holyData['dataList']);

//                     return Column(
//                       children: [
//                         ListTile(
//                           title: Center(
//                             child: Text(
//                               headingName,
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         ListTile(
//                           title: Row(
//                             children: [
//                               IconButton(
//                                 icon: Icon(Icons.arrow_left),
//                                 onPressed: () {
//                                   setState(() {
//                                     if (currentChapterIndex > 0) {
//                                       currentChapterIndex--;
//                                       updateSelectedChapter(holyDocs);
//                                     }
//                                   });
//                                 },
//                               ),
//                               Expanded(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedChapterName = chapterName;
//                                       selectedChapterDataList = dataList;
//                                     });
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         chapterName,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.arrow_right),
//                                 onPressed: () {
//                                   setState(() {
//                                     if (currentChapterIndex <
//                                         holyDocs.length - 1) {
//                                       currentChapterIndex++;
//                                       updateSelectedChapter(holyDocs);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (selectedChapterName.isNotEmpty &&
//                             selectedChapterDataList.isNotEmpty)
//                           ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: selectedChapterDataList.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: Text(
//                                   selectedChapterDataList[index],
//                                 ),
//                               );
//                             },
//                           ),
//                       ],
//                     );
//                   } else {
//                     return const Text('No Data Found');
//                   }
//                 }
//                 if (snapshot.hasError) {
//                   return const Text('Error Data Not Found');
//                 } else {
//                   return const Text('Error Data Not Found');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void updateSelectedChapter(List<QueryDocumentSnapshot> holyDocs) {
//     final holyData = holyDocs[currentChapterIndex];
//     selectedChapterName = holyData["chapterName"];
//     selectedChapterDataList = List<String>.from(holyData['dataList']);
//   }
// }








// class _HolyBibleScreenState extends State<HolyBibleScreen> {
//   final firebaseServices = FirebaseServices();
//   int currentChapterIndex = 0;
//   bool dataListVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Holy Bible"),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: firebaseServices.holyBible
//                 .orderBy("created_at", descending: false)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: Lottie.asset("assets/loading.json", repeat: true),
//                 );
//               }
//               if (snapshot.hasData) {
//                 final List<QueryDocumentSnapshot> holyDocs =
//                     snapshot.data!.docs;
//                 if (holyDocs.isNotEmpty) {
//                   final holyData = holyDocs[currentChapterIndex];
//                   final chapterName = holyData["chapterName"];
//                   final headingName = holyData["heading"];
//                   final dataList = List.from(holyData['dataList']);

//                   return Column(
//                     children: [
//                       ListTile(
//                         title: Center(
//                           child: Text(
//                             headingName,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         title: Row(
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.arrow_left),
//                               onPressed: () {
//                                 setState(() {
//                                   if (currentChapterIndex > 0) {
//                                     currentChapterIndex--;
//                                   }
//                                 });
//                               },
//                             ),
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     // Toggle visibility of data on tap
//                                     dataListVisible = !dataListVisible;
//                                   });
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       chapterName,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.arrow_right),
//                               onPressed: () {
//                                 setState(() {
//                                   if (currentChapterIndex <
//                                       holyDocs.length - 1) {
//                                     currentChapterIndex++;
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (dataListVisible)
//                         Expanded(
//                           child: ListView.builder(
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             itemCount: dataList.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: Text(dataList[index].toString()),
//                               );
//                             },
//                           ),
//                         ),
//                     ],
//                   );
//                 } else {
//                   return const Text('No Data Found');
//                 }
//               }
//               if (snapshot.hasError) {
//                 return const Text('Error Data Not Found');
//               } else {
//                 return const Text('Error Data Not Found');
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildCard(title, description) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title),
//           Text(description),
//         ],
//       ),
//     );
//   }
// }



 // StreamBuilder<QuerySnapshot>(
        //   stream: firebaseServices.holyBible
        //       .orderBy("created_at", descending: false)
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: Lottie.asset("assets/loading.json", repeat: true),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       final List<QueryDocumentSnapshot> holyDocs =
        //           snapshot.data!.docs;
        //       return ListView.builder(
        //         shrinkWrap: true,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: holyDocs.length,
        //         itemBuilder: (ctx, index) {
        //           // final holyData = holyDocs[index];
        //           // final serialNumber = index + 1;
        //           // final documentId = holyData.id;
        //           // final chapterName = holyData["chapterName"];
        //           // final headingName = holyData["heading"];
        //           // final dataList = List.from(holyData['dataList']);
        //           // return ListTile(
        //           //   leading: Text(headingName),
        //           //   title: Text(chapterName),
        //           //   subtitle: Column(
        //           //     crossAxisAlignment: CrossAxisAlignment.start,
        //           //     children: dataList.map((item) {
        //           //       return Text(item);
        //           //     }).toList(),
        //           //   ),
        //           // );
        //           final holyData = holyDocs[index];
        //           final serialNumber = index + 1;
        //           final documentId = holyData.id;
        //           final chapterName = holyData["chapterName"];
        //           final headingName = holyData["heading"];
        //           final dataList = List.from(holyData['dataList']);
        //           bool showData = false;
        //           return Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               ListTile(
        //                 title: Center(
        //                   child: Text(
        //                     headingName,
        //                     style: TextStyle(
        //                       fontSize: 20,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               ListTile(
        //                 title: Row(
        //                   children: [
        //                     IconButton(
        //                       icon: Icon(Icons.arrow_left),
        //                       onPressed: () {
        //                         setState(() {
        //                           showData = false;
        //                         });
        //                       },
        //                     ),
        //                     Expanded(
        //                       child: GestureDetector(
        //                         onTap: () {
        //                           setState(() {
        //                             showData = !showData;
        //                           });
        //                         },
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.center,
        //                           children: [
        //                             Text(
        //                               chapterName,
        //                               style: TextStyle(
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.bold,
        //                               ),
        //                             ),
        //                             Icon(
        //                               showData
        //                                   ? Icons.keyboard_arrow_up
        //                                   : Icons.keyboard_arrow_down,
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     IconButton(
        //                       icon: Icon(Icons.arrow_right),
        //                       onPressed: () {
        //                         setState(() {
        //                           showData = true;
        //                         });
        //                       },
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               if (showData)
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: dataList.map((item) {
        //                     return Padding(
        //                       padding: EdgeInsets.symmetric(horizontal: 16),
        //                       child: Text(item),
        //                     );
        //                   }).toList(),
        //                 ),
        //             ],
        //           );
        //         },
        //       );
        //     }
        //     if (snapshot.hasError) {
        //       return const Text('Error Data Not Found');
        //     } else {
        //       return const Text('Error Data Not Found');
        //     }
        //   },
        // ),
    