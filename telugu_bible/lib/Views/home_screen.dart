import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telugu_bible/Views/about_the_author_screen.dart';
import 'package:telugu_bible/Views/contacts_screen.dart';
import 'package:telugu_bible/Views/english_bible_screen.dart';
import 'package:telugu_bible/Views/favorite_verses_screen.dart';
import 'package:telugu_bible/Views/from_the_associates_screen.dart';
import 'package:telugu_bible/Views/from_the_author_screen.dart';
import 'package:telugu_bible/Views/history_of_mnp_screen.dart';
import 'package:telugu_bible/Views/holy_bible_screen.dart';
import 'package:telugu_bible/Views/how_to_use_app_screen.dart';
import 'package:telugu_bible/Views/schedule_bible_study.dart';
import 'package:telugu_bible/Views/schedule_family_prayer_screen.dart';
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
import 'package:telugu_bible/utis/config.dart';
import 'package:telugu_bible/utis/snack_bar_msg.dart';
import 'package:telugu_bible/widgets/custom_square_button_widget.dart';
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

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Welcome to Satya Veda Anweshana"),
      ),
      body: buildBodySection(context),
      drawer: buildDrawerWidget(),
      bottomSheet: Container(
        // margin: EdgeInsets.only(left:AppDimensionHelper.getHt(6)),
        padding: EdgeInsets.all(AppDimensionHelper.getHt(5)),
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.to(() => const SearchScreen()),
              child: Container(
                height: AppDimensionHelper.getHt(50),
                width: AppDimensionHelper.getWd(70),
                decoration: const BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                  child: Text(
                    "Voice Search",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => Get.to(() => const SearchScreen()),
                child: Container(
                  height: AppDimensionHelper.getHt(50),
                  // width: AppDimensionHelper.getWd(70),
                  decoration: const BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Center(
                    child: Text(
                      "Search\n Please enter the key Word",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: AppColors.kBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.to(() => const HowtoUseAppScreen()),
              child: Container(
                height: AppDimensionHelper.getHt(50),
                width: AppDimensionHelper.getWd(70),
                decoration: const BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                  child: Text(
                    "How to use App",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//====================== body Section ===========================
  Widget buildBodySection(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(AppDimensionHelper.getHt(4)),
              margin: EdgeInsets.all(AppDimensionHelper.getHt(4)),
              height: AppDimensionHelper.getHt(180),
              child: StreamBuilder(
                stream: firebaseServices.dailyQuotesOfTheDay
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final List<QueryDocumentSnapshot> dailyQuotesData =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      // itemCount: dailyQuotesData.length,
                      itemCount: 1,
                      itemBuilder: (ctx, index) {
                        final quotesData = dailyQuotesData[index];
                        // final serialNumber = index + 1;
                        final title = quotesData["name"];
                        final quoteOftheDay = quotesData["quote"];
                        final createdDate = quotesData["created_at"];

                        final formatedDate = AppConfigData()
                            .formatDateWithTimeStamp(createdDate);
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
                                        // _shareQuotesApp(title, quoteOftheDay);
                                        AppConfigData().shareQuotesApp(
                                            title, quoteOftheDay);
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
            buildMenusSection(context),
            SizedBox(height: AppDimensionHelper.getHt(20)),
            //App Name and Author Name
            Column(
              children: [
                Text("Satya",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(30),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(5)),
                Text("Veda",
                    style: GoogleFonts.abel(
                        fontSize: AppDimensionHelper.getHt(25),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(5)),
                Text("Anweshana",
                    style: GoogleFonts.lato(
                        fontSize: AppDimensionHelper.getHt(30),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: AppDimensionHelper.getHt(35)),
                Text("Telugu Bible App",
                    style: GoogleFonts.nunitoSans(
                        fontSize: AppDimensionHelper.getHt(40),
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

//============== Menu Sections ======================
  Widget buildMenusSection(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      clipBehavior: Clip.antiAlias,
      spacing: AppDimensionHelper.getHt(20),
      runSpacing: AppDimensionHelper.getHt(10),
      children: [
        CustomSquareButtonWidget(
            text: "Menu", onTap: () => scaffoldKey.currentState?.openDrawer()),
        CustomSquareButtonWidget(text: "Index", onTap: () {}),
        CustomSquareButtonWidget(
            text: "Telugu Bible",
            onTap: () => Get.to(() => const HolyBibleScreen())),
        CustomSquareButtonWidget(
            text: "English Bible",
            onTap: () => Get.to(() => const EnglishBibleScreen())),
        CustomSquareButtonWidget(
            text: "Go to", onTap: () => Get.to(() => const SearchScreen())),
        CustomSquareButtonWidget(text: "Notifications", onTap: () {}),
        CustomSquareButtonWidget(
            text: "From the Author",
            onTap: () => Get.to(() => const FromTheAuthorScreen())),
        CustomSquareButtonWidget(
            text: "From the Associates",
            onTap: () => Get.to(() => const FromTheAssociatesScreen())),
        CustomSquareButtonWidget(
            text: "Bible Quiz",
            onTap: () => Get.to(() => const BibleQuizScreen())),
        CustomSquareButtonWidget(
            text: "History of MNP",
            onTap: () => Get.to(() => const HistoryOfMNPScreen())),
        CustomSquareButtonWidget(
            text: "About the Author",
            onTap: () => Get.to(() => const AboutTheAuthorScreen())),
        CustomSquareButtonWidget(
            text: "Contact the Author",
            onTap: () => Get.to(() => const ContactsScreen())),
      ],
    );
  }

//================ Build drawer widget  =====================
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
            onTap: () => Get.to(() => const ScheduleYourFamilyPrayerScreen()),
            leading: const Icon(Icons.schedule, color: Colors.blueGrey),
            title: Text("Schedule Your Family Prayer",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const HolyBibleScreen()),
            leading: const Icon(Icons.menu_book, color: Colors.blueGrey),
            title: Text("Know your Bible Knowledge",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Get.to(() => const ContactsScreen()),
            leading:
                const Icon(Icons.facebook_outlined, color: Colors.blueGrey),
            title: Text("Connect us on Social Media",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => _shareApp(),
            leading: const Icon(Icons.share, color: Colors.blueGrey),
            title: Text("Share the App",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => _shareApp(),
            leading: const Icon(Icons.update, color: Colors.blueGrey),
            title: Text("Update the App",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => AppConfigData().rateTheApp(),
            leading: const Icon(Icons.rate_review, color: Colors.blueGrey),
            title: Text("Rate the App",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => showSnackBarMessage(
                "Umm", "Currently no apps available", Colors.indigo),
            leading: const Icon(Icons.apps, color: Colors.blueGrey),
            title: Text("Other Connected Apps",
                style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold)),
          ),
          ListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(Icons.home, color: Colors.blueGrey),
            title: Text("Home",
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

//================= Share App Functionality =================
  void _shareApp() {
    const String appUrl =
        "https://play.google.com/store/apps/details?id=com.awiskartech.telugu_bible";
    const String message = "Check out this amazing app: $appUrl";
    Share.share(message);
  }

//================= Logout Functionality =======================
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
