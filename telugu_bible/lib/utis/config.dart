import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConfigData {
//======================== Format Date ================================
  String formatDateWithTimeStamp(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return dateFormat.format(dateTime);
  }

//=============== Share Quotes Functionality ==================
  void shareQuotesApp(String title, String quote) {
    const String appUrl =
        "https://play.google.com/store/apps/details?id=com.awiskartech.telugu_bible";
    final String message =
        "Check out this quote from the app \"$title\":\n\n\"$quote\"\n\nDownload the app from: $appUrl";
    Share.share(message);
  }

//=============== rate the update ==================
  void rateTheApp() async {
    const String appUrl =
        "https://play.google.com/store/apps/details?id=com.awiskartech.telugu_bible";

    if (await canLaunchUrl(Uri.parse(appUrl))) {
      await launchUrl(Uri.parse(appUrl));
    } else {
      throw 'Could not launch $appUrl';
    }
  }
}
