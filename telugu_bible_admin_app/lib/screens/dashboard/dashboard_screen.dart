import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:telugu_admin/screens/Admin/add_daily_quotes.dart';
import 'package:telugu_admin/screens/Admin/admin_english_bible_screen.dart';
import 'package:telugu_admin/screens/Admin/all_customer_list.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/screens/Admin/from_the_author_screen.dart';
import 'package:telugu_admin/services/firebase_db_services.dart';
import 'package:telugu_admin/widgets/custom_text_widget.dart';
import 'package:date_time_format/date_time_format.dart';
import '../Admin/admin_analytics_screen.dart';
import '../../constants/utils/styles.utils.dart';
import '../Admin/admin_holy_bible_screen.dart';

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

      case AdminEnglishBibleScreen.id:
        setState(() {
          _selectedScreen = const AdminEnglishBibleScreen();
        });
        break;

      case AdminFromTheAuthorScreen.id:
        setState(() {
          _selectedScreen = const AdminFromTheAuthorScreen();
        });
        break;

      case AddDailyQuotes.id:
        setState(() {
          _selectedScreen = const AddDailyQuotes();
        });
        break;
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
                text: "Satya Veda Anweshana Telugu Bible",
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
            title: 'Telugu Bible',
            route: AdminHolyBibleScreen.id,
            icon: FontAwesomeIcons.bookBible,
          ),
          AdminMenuItem(
            title: 'English Bible',
            route: AdminEnglishBibleScreen.id,
            icon: FontAwesomeIcons.bookBible,
          ),
          AdminMenuItem(
            title: 'From The Author',
            route: AdminFromTheAuthorScreen.id,
            icon: FontAwesomeIcons.accessibleIcon,
          ),
          AdminMenuItem(
            title: 'Add Quotes',
            route: AddDailyQuotes.id,
            icon: FontAwesomeIcons.noteSticky,
          ),
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
