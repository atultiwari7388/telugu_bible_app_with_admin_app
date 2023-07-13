import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telugu_bible/Views/contacts_screen.dart';
import 'package:telugu_bible/Views/favorite_verses_screen.dart';
import 'package:telugu_bible/Views/holy_bible_screen.dart';
import 'package:telugu_bible/Views/schedule_bible_study.dart';
import 'package:telugu_bible/Views/sermon_notes.dart';
import 'package:telugu_bible/controllers/auth_controller.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final authController = Get.put(AuthController());

  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>>? searchData;

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _speech?.cancel();
  }

  Future<void> _listen() async {
    if (_isListening) return;

    bool available = await _speech!.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) {
        log('Speech recognition error: $error');
      },
    );

    if (available) {
      setState(() {
        _isListening = true;
        _text = '';
      });

      _speech!.listen(
        onResult: (SpeechRecognitionResult result) {
          setState(() {
            _text = result.recognizedWords;
            searchController.text = _text; // Update the search bar text
          });
          searchForData(_text);
        },
      );
    } else {
      log('The user has denied the use of speech recognition.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Search"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic_off : Icons.mic),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchForData(value);
              },
              decoration: const InputDecoration(
                hintText: "Search",
              ),
            ),
          ),
          Expanded(
            child: searchData != null && searchData!.isNotEmpty
                ? ListView.builder(
                    itemCount: searchData!.length,
                    itemBuilder: (context, index) {
                      final headingName = searchData![index]["heading"];
                      final chapterName = searchData![index]['chapterName'];
                      final List<dynamic> dataList =
                          searchData![index]['dataList'];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headingName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            chapterName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              final data = dataList[index];
                              return ListTile(
                                title: Text(data),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  )
                : const Center(
                    child: Text('No search results found.'),
                  ),
          ),
        ],
      ),
    );
  }

  void searchForData(String searchText) {
    if (searchText.isEmpty) {
      // Clear the search data and update the UI
      searchData = [];
      setState(() {});
      return;
    }
    searchData = []; // Initialize searchData as an empty list

    final collectionRef = FirebaseFirestore.instance.collection('holyBible');
    collectionRef.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((document) {
          final headingName = document['heading'] as String?;
          final chapterName = document['chapterName'] as String?;
          final List<dynamic>? dataList =
              document['dataList'] as List<dynamic>?;

          if (headingName != null && chapterName != null && dataList != null) {
            bool hasMatch = false;

            for (var data in dataList) {
              if (data is String &&
                  _isTextMatch(searchText, data.toLowerCase())) {
                hasMatch = true;
                break;
              }
            }

            if (hasMatch) {
              searchData!.add({
                'heading': headingName,
                'chapterName': chapterName,
                'dataList': dataList,
              });
            }
          }
        });

        setState(() {}); // Refresh the UI to show the search results
      }
    });
  }

  bool _isTextMatch(String searchText, String text) {
    // Convert Telugu text to lowercase for case-insensitive matching
    searchText = searchText.toLowerCase();
    text = text.toLowerCase();

    // Remove diacritical marks from Telugu text for better matching
    searchText = _removeDiacriticalMarks(searchText);
    text = _removeDiacriticalMarks(text);

    // Check if the search text is contained in the Telugu text
    return text.contains(searchText);
  }

  String _removeDiacriticalMarks(String text) {
    final Map<String, String> diacriticalMarks = {
      '్అ': 'అ',
      '్ఆ': 'ఆ',
      '్ఇ': 'ఇ',
      '్ఈ': 'ఈ',
      '్ఉ': 'ఉ',
      '్ఊ': 'ఊ',
      '్ఋ': 'ఋ',
      '్ౠ': 'ౠ',
      '్ఌ': 'ఌ',
      '్ౡ': 'ౡ',
      '్ఎ': 'ఎ',
      '్ఏ': 'ఏ',
      '్ఐ': 'ఐ',
      '్ఒ': 'ఒ',
      '్ఓ': 'ఓ',
      '్ఔ': 'ఔ',
      'ంం': 'ం',
      'ంః': 'ః',
      'ఁఁ': 'ఁ',
      '౦': '0',
      '౧': '1',
      '౨': '2',
      '౩': '3',
      '౪': '4',
      '౫': '5',
      '౬': '6',
      '౭': '7',
      '౮': '8',
      '౯': '9',
    };

    // Replace Telugu diacritical marks with their base characters
    diacriticalMarks.forEach((mark, base) {
      text = text.replaceAll(mark, base);
    });

    return text;
  }
}
