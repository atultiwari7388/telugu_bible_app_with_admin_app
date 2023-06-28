import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:telugu_bible/controllers/auth_controller.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/utis/app_style.dart';
import 'package:get/get.dart';
import 'package:telugu_bible/utis/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Lottie.asset("assets/welcome_ani.json",
                  fit: BoxFit.contain, repeat: true),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Container()),
                    Text("Hey! Welcome",
                        style: AppFontStyles.MediumHeadingText),
                    SizedBox(height: AppDimensionHelper.getHt(20)),
                    ElevatedButton.icon(
                      onPressed: () => authController.signInWithGoogle(context),
                      // onPressed: () => authController.signInWithGoogle(context),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.white),
                      label: const Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        minimumSize: Size(
                            double.maxFinite, AppDimensionHelper.getHt(46)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensionHelper.getHt(60)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
