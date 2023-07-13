import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:telugu_bible/Views/about_the_author_screen.dart';
import 'package:telugu_bible/Views/contacts_screen.dart';
import 'package:telugu_bible/Views/english_bible_screen.dart';
import 'package:telugu_bible/Views/favorite_verses_screen.dart';
import 'package:telugu_bible/Views/from_the_associates_screen.dart';
import 'package:telugu_bible/Views/from_the_author_screen.dart';
import 'package:telugu_bible/Views/history_of_mnp_screen.dart';
import 'package:telugu_bible/Views/holy_bible_screen.dart';
import 'package:telugu_bible/Views/my_profile_screen.dart';
import 'package:telugu_bible/Views/schedule_bible_study.dart';
import 'package:telugu_bible/Views/search_screen.dart';
import 'package:telugu_bible/Views/sermon_notes.dart';
import 'package:telugu_bible/controllers/auth_controller.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/services/firebase_services.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';

import 'bible_quiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final authController = Get.put(AuthController());
  final FirebaseServices firebaseServices = FirebaseServices();

  String formatDateWithTimeStamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Quotes of the Day"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //quote os the day
            Container(
              // padding: EdgeInsets.all(AppDimensionHelper.getHt(4)),
              margin: EdgeInsets.all(AppDimensionHelper.getHt(4)),
              height: 200,
              child: StreamBuilder(
                stream: firebaseServices.dailyQuotesOfTheDay
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final List<QueryDocumentSnapshot> dailyQuotesData =
                        snapshot.data!.docs;
                    return ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      // itemCount: dailyQuotesData.length,
                      itemCount: 1,
                      itemBuilder: (ctx, index) {
                        final quotesData = dailyQuotesData[index];
                        // final serialNumber = index + 1;
                        final title = quotesData["name"];
                        final quoteOftheDay = quotesData["quote"];
                        final createdDate = quotesData["created_at"];

                        final formatedDate =
                            formatDateWithTimeStamp(createdDate);
                        return Container(
                          padding: EdgeInsets.all(AppDimensionHelper.getHt(8)),
                          margin: EdgeInsets.all(AppDimensionHelper.getHt(8)),
                          decoration: BoxDecoration(
                            color: AppColors.kWhiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppDimensionHelper.getHt(15)),
                              topRight:
                                  Radius.circular(AppDimensionHelper.getHt(15)),
                              bottomRight:
                                  Radius.circular(AppDimensionHelper.getHt(15)),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatedDate,
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: AppColors.kDarkGreyColor)),
                                  IconButton(
                                      onPressed: () {
                                        _shareQuotesApp(title, quoteOftheDay);
                                      },
                                      icon: const Icon(Icons.share))
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 16, color: Colors.blueGrey)),
                              const SizedBox(height: 8),
                              Text(quoteOftheDay,
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Sorry !, Data not Found"));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("Sorry !, Data not Found"));
                  }
                }),
              ),
            ),
            SizedBox(height: AppDimensionHelper.getHt(10)),
            buildMenusSection(context),
            SizedBox(height: AppDimensionHelper.getHt(10)),

            //App Name and Author Name
            Column(
              children: [
                Text("Satya",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(25),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(5)),
                Text("Veda",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(25),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(5)),
                Text("Anweshana",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(25),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(15)),
                Text("Telugu Bible App",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(30),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      drawer: buildDrawerWidget(),
    );
  }

  Widget buildMenusSection(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      clipBehavior: Clip.antiAlias,
      spacing: AppDimensionHelper.getHt(8),
      runSpacing: AppDimensionHelper.getHt(10),
      children: [
        ElevatedButton(
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
            child: Text("Menu",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const HolyBibleScreen()),
            child: Text("Telugu\n Bible",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const EnglishBibleScreen()),
            child: Text("English\n Bible",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const SearchScreen()),
            child: Text("Go to",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const FromTheAuthorScreen()),
            child: Text("From the\n Author",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const FromTheAssociatesScreen()),
            child: Text("From the\n Associates",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const BibleQuizScreen()),
            child: Text("Bible Quiz",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const HistoryOfMNPScreen()),
            child: Text("History of\n MNP",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const AboutTheAuthorScreen()),
            child: Text("About the\n Author",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
        ElevatedButton(
            onPressed: () => Get.to(() => const ContactsScreen()),
            child: Text("Contact the\n Author",
                style:
                    GoogleFonts.nunitoSans(fontSize: 16, color: Colors.white))),
      ],
    );
  }

  void _shareQuotesApp(String title, String quote) {
    const String appUrl =
        "https://play.google.com/store/apps/details?id=com.awiskartech.telugu_bible";
    final String message =
        "Check out this quote from the app \"$title\":\n\n\"$quote\"\n\nDownload the app from: $appUrl";
    Share.share(message);
  }

  Widget buildDrawerWidget() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.kPrimaryColor),
              child: Center(
                child: Text(
                  "Telugu Bible App",
                  style: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
          ListTile(
            onTap: () => Get.to(() => const MyProfileScreen()),
            leading: const Icon(Icons.account_circle, color: Colors.blueGrey),
            title: Text("My Account",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const HolyBibleScreen()),
            leading: const Icon(Icons.menu_book, color: Colors.blueGrey),
            title: Text("Holy Bible",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const SermonNotesScreen()),
            leading: const Icon(Icons.note_sharp, color: Colors.blueGrey),
            title: Text("Note the Sermons",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const FavoriteVersesScreen()),
            leading: const Icon(Icons.star, color: Colors.blueGrey),
            title: Text("Save the Memory Verses",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const ScheduleYourBibleStudyScreen()),
            leading: const Icon(Icons.schedule, color: Colors.blueGrey),
            title: Text("Schedule Your Bible Study",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const ContactsScreen()),
            leading: const Icon(Icons.contact_mail, color: Colors.blueGrey),
            title: Text("Connect us on Social Media",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const SearchScreen()),
            leading: const Icon(Icons.search, color: Colors.blueGrey),
            title: Text("Search from bible",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => _shareApp(),
            leading: const Icon(Icons.share, color: Colors.blueGrey),
            title: Text("Share this app",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => showSnackBarMessage("Sorry !",
                "Currently This Functionality not Available", Colors.orange),
            leading: const Icon(Icons.rate_review, color: Colors.blueGrey),
            title: Text("Rate us",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => buildLogoutWidget(),
            leading: const Icon(Icons.logout, color: Colors.blueGrey),
            title: Text("Logout",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _shareApp() {
    const String appUrl =
        "https://play.google.com/store/apps/details?id=com.awiskartech.telugu_bible";
    const String message = "Check out this amazing app: $appUrl";
    Share.share(message);
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
