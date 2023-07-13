import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telugu_admin/screens/Admin/add_daily_quotes.dart';
import 'package:telugu_admin/screens/Admin/admin_transaction_screen.dart';
import 'package:telugu_admin/screens/Admin/admin_appointment_screen.dart';
import 'package:telugu_admin/screens/Admin/all_customer_list.dart';
import 'package:telugu_admin/screens/Admin/admin_platform_screen.dart';
import 'package:telugu_admin/screens/Admin/admin_total_agents.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';
import 'package:telugu_admin/widgets/custom_text_widget.dart';
import 'package:date_time_format/date_time_format.dart';
import '../Admin/admin_analytics_screen.dart';
import '../../constants/utils/styles.utils.dart';

class AdminHomeScreen extends StatefulWidget {
  static const String id = "admin-menu";

  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  Widget _selectedScreen = const AdminAnalyticsScreen();

  screenSelector(item) {
    switch (item.route) {
      case AdminAnalyticsScreen.id:
        setState(() {
          _selectedScreen = const AdminAnalyticsScreen();
        });
        break;

      case AdminCustomerScreen.id:
        setState(() {
          _selectedScreen = const AdminCustomerScreen();
        });
        break;

      case AdminHolyBibleScreen.id:
        setState(() {
          _selectedScreen = const AdminHolyBibleScreen();
        });
        break;

      // case AdminContactsScreen.id:
      //   setState(() {
      //     _selectedScreen = const AdminContactsScreen();
      //   });
      //   break;

      case AddDailyQuotes.id:
        setState(() {
          _selectedScreen = const AddDailyQuotes();
        });
        break;

      // case AdminBibleQuizScreen.id:
      //   setState(() {
      //     _selectedScreen = const AdminBibleQuizScreen();
      //   });
      //   break;

      // case AdminBibleDictionaryScreen.id:
      //   setState(() {
      //     _selectedScreen = const AdminBibleDictionaryScreen();
      //   });
      //   break;

      // case AdminVideoScreen.id:
      //   setState(() {
      //     _selectedScreen = const AdminVideoScreen();
      //   });
      //   break;
      // case AdminSettingsScreen.id:
      //   setState(() {
      //     _selectedScreen = const AdminSettingsScreen();
      //   });
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        elevation: 0,
        title: Row(
          children: [
            const Visibility(
              child: CustomTextWidget(
                text: "Telugu Bible",
                size: 20,
                color: AppColors.kLightGreyColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 1,
              height: 22,
              color: AppColors.kLightGreyColor,
            ),
            const SizedBox(width: 24),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to Logout."),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("No",
                            style: AppStyles.subtitleText
                                .copyWith(color: AppColors.kRedColor)),
                      ),
                      TextButton(
                        onPressed: () =>
                            FirebaseDatabaseServices().signOut(context),
                        child: Text("Yes",
                            style: AppStyles.subtitleText
                                .copyWith(color: Colors.green)),
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: const [
                  CustomTextWidget(
                    text: "LogOut",
                    color: AppColors.kLightGreyColor,
                  ),
                  SizedBox(width: 10),
                  FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                      color: AppColors.kLightGreyColor),
                ],
              ),
            )
          ],
        ),
        iconTheme: const IconThemeData(color: AppColors.kDarke),
      ),
      sideBar: SideBar(
        textStyle:
            AppStyles.subtitleText.copyWith(color: AppColors.kBlackColor),
        iconColor: AppColors.kBlackColor,
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: AdminAnalyticsScreen.id,
            icon: FontAwesomeIcons.arrowTrendUp,
          ),
          AdminMenuItem(
            title: 'Customers',
            route: AdminCustomerScreen.id,
            icon: FontAwesomeIcons.users,
          ),
          AdminMenuItem(
            title: 'Holy Bible',
            route: AdminHolyBibleScreen.id,
            icon: FontAwesomeIcons.user,
          ),
          AdminMenuItem(
            title: 'Add Quotes',
            route: AddDailyQuotes.id,
            icon: FontAwesomeIcons.noteSticky,
          ),
          // AdminMenuItem(
          //   // title: 'Contacts',
          //   // route: AdminContactsScreen.id,
          //   // icon: FontAwesomeIcons.amazon,
          // ),
          // AdminMenuItem(
          //   title: 'Bible Quiz',
          //   route: AdminBibleQuizScreen.id,
          //   icon: FontAwesomeIcons.calendar,
          // ),
          // AdminMenuItem(
          //   title: 'Bible Dictionary',
          //   route: AdminBibleDictionaryScreen.id,
          //   icon: FontAwesomeIcons.clockRotateLeft,
          // ),

          // AdminMenuItem(
          //   title: 'Videos',
          //   route: AdminVideoScreen.id,
          //   icon: FontAwesomeIcons.video,
          // ),
          // AdminMenuItem(
          //   title: 'Settings',
          //   route: AdminSettingsScreen.id,
          //   icon: FontAwesomeIcons.repeat,
          // ),
          // AdminMenuItem(
          //   title: 'Logout',
          //   route: AdminPlatformScreen.id,
          //   icon: FontAwesomeIcons.arrowRightFromBracket,
          // ),
        ],
        selectedRoute: AdminHomeScreen.id,
        onSelected: (item) {
          screenSelector(item);
          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              DateTimeFormat.format(DateTime.now(),
                  format: AmericanDateFormats.dayOfWeek),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(child: _selectedScreen),
    );
  }
}
