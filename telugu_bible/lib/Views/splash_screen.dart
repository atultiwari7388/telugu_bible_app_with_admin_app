import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telugu_bible/Views/home_screen.dart';
import 'package:telugu_bible/Views/login_screen.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/utis/app_constants.dart';
import 'package:telugu_bible/utis/colors.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadSplashScreen();
  }

  _loadSplashScreen() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Device is connected, navigate to DashboardScreen
      // Check if the user is already logged in
      User? user = _auth.currentUser;
      if (user != null) {
        // User is already logged in, navigate to the home screen
        await Future.delayed(const Duration(seconds: 6));
        Get.off(() => const HomeScreen());
      } else {
        // User is not logged in, navigate to the login screen
        await Future.delayed(const Duration(seconds: 6));
        Get.off(() => const LoginScreen());
      }
    } else {
      Get.snackbar(
        "Umm ",
        "Check your Internet Connection Please",
        backgroundColor: AppColors.kPrimaryColor,
        colorText: AppColors.kWhiteColor,
      );
      await Future.delayed(const Duration(seconds: 5)).then((value) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // //top logo
            // Container(
            //   height: 150,
            //   width: 150,
            //   color: Colors.red,
            //   child: const Text("Logo"),
            // ),
            // //father logo
            // Container(
            //   height: 150,
            //   width: 150,
            //   color: Colors.green,
            //   child: const Text("Father Logo"),
            // ),
            // //owner app name
            // Text("Dr. Nirmala Prasad Madduluri"),
            // //app name
            // Text("Satya Veda anweshana \nTelugu Bible App"),

            // //In my bottom , show dr. name
            // Text("By \nDr. Girija Prasad Samavedam"),

            Container(
              height: AppDimensionHelper.getHt(600),
              width: double.maxFinite,
              // margin: EdgeInsets.all(2),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"), fit: BoxFit.contain),
              ),
            ),
            // Expanded(child: Container()),
            const Text(
              AppConstants.APP_NAME,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.kBlackColor,
              ),
            ),
            SizedBox(height: AppDimensionHelper.getHt(20)),
            const CircularProgressIndicator(),
            SizedBox(height: AppDimensionHelper.getHt(10)),
          ],
        ),
      ),
    );
  }
}
