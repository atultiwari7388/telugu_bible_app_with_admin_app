import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telugu_bible/Views/bible_dictionary_screen.dart';
import 'package:telugu_bible/Views/bible_quiz.dart';
import 'package:telugu_bible/Views/contacts_screen.dart';
import 'package:telugu_bible/Views/favorite_verses_screen.dart';
import 'package:telugu_bible/Views/holy_bible_screen.dart';
import 'package:telugu_bible/Views/labels_screen.dart';
import 'package:telugu_bible/Views/search_history.dart';
import 'package:telugu_bible/Views/sermon_notes.dart';
import 'package:telugu_bible/controllers/auth_controller.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Search"),
      ),
      body: Container(),
      drawer: buildDrawerWidget(),
    );
  }

  // void onSelected(BuildContext context,int item) {
  //   switch(item){
  //     case 0:
  //       // navigate to settings screen
  //       print("Settings Clicked");
  //       break;
  //   }
  // }

  //============================== Drawer Section ==========================
  Drawer buildDrawerWidget() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: CircleAvatar(
                // radius: 70,
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
              accountName: Text(user!.displayName!),
              accountEmail: Text(user!.email!),
            ),
          ),
          ListTile(
            onTap: () => Get.to(() => const HolyBibleScreen()),
            leading: const Icon(Icons.menu_book),
            title: const Text("Holy Bible"),
          ),
          ListTile(
            onTap: () => Get.to(() => const BibleQuizScreen()),
            leading: const Icon(Icons.quiz),
            title: const Text("Bible Quiz"),
          ),
          ListTile(
            onTap: () => Get.to(() => const FavoriteVersesScreen()),
            leading: const Icon(Icons.star),
            title: const Text("Favorite verses"),
          ),
          ListTile(
            onTap: () => Get.to(() => const LabelsScreen()),
            leading: const Icon(Icons.label),
            title: const Text("Labels"),
          ),
          ListTile(
            onTap: () => Get.to(() => const SermonNotesScreen()),
            leading: const Icon(Icons.note_sharp),
            title: const Text("Sermon Notes"),
          ),
          ListTile(
            onTap: () => Get.to(() => const BibleDictionaryScreen()),
            leading: const Icon(Icons.book),
            title: const Text("Bible Dictionary"),
          ),
          ListTile(
            onTap: () => Get.to(() => const SearchHistoryScreen()),
            leading: const Icon(Icons.history),
            title: const Text("Search History"),
          ),
          ListTile(
            onTap: () => Get.to(() => const ContactsScreen()),
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contacts"),
          ),
          ListTile(
            onTap: () => showSnackBarMessage("Sorry !",
                "Currently This Functionality not Available", Colors.orange),
            leading: const Icon(Icons.share),
            title: const Text("Share this app"),
          ),
          ListTile(
            onTap: () => showSnackBarMessage("Sorry !",
                "Currently This Functionality not Available", Colors.orange),
            leading: const Icon(Icons.rate_review),
            title: const Text("Rate us"),
          ),
          ListTile(
            onTap: () => buildLogoutWidget(),
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildLogoutWidget() {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to Logout from this App"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No",
                  style: AppFontStyles.smallText.copyWith(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                authController.logout();
              },
              child: Text("Yes",
                  style: AppFontStyles.smallText.copyWith(color: Colors.green)),
            )
          ],
        );
      },
    );
  }
}
