import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteVersesScreen extends StatefulWidget {
  const FavoriteVersesScreen({Key? key}) : super(key: key);

  @override
  _FavoriteVersesScreenState createState() => _FavoriteVersesScreenState();
}

class _FavoriteVersesScreenState extends State<FavoriteVersesScreen> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final favoriteDataRef = FirebaseFirestore.instance.collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Data'),
      ),
      body: currentUser != null
          ? StreamBuilder<QuerySnapshot>(
              stream: favoriteDataRef
                  .doc(currentUser!.uid)
                  .collection('verses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final favoriteDataList = snapshot.data!.docs;
                  if (favoriteDataList.isNotEmpty) {
                    return ListView.builder(
                      itemCount: favoriteDataList.length,
                      itemBuilder: (context, index) {
                        final favoriteData = favoriteDataList[index];
                        final data = favoriteData['data'];
                        final chapterName = favoriteData['chapterName'];
                        final heading = favoriteData['heading'];

                        return ListTile(
                          title: Text(data),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showConfirmationDialog(favoriteData.reference.id);
                            },
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(chapterName),
                              Text(heading),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No favorite data found.'),
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Failed to fetch favorite data.'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          : const Center(
              child: Text('User not logged in.'),
            ),
    );
  }

  // Show confirmation dialog
  void showConfirmationDialog(String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Data'),
          content: const Text(
              'Are you sure you want to remove this data from favorites?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                removeDataFromFavorites(documentId);
                Navigator.of(context).pop();
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

//remove data from
  void removeDataFromFavorites(String documentId) {
    favoriteDataRef
        .doc(currentUser!.uid)
        .collection('verses')
        .doc(documentId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data removed from favorites')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove data from favorites')),
      );
    });
  }
}
