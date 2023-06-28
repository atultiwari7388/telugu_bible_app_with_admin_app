import 'package:flutter/material.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';

class AppStyles {
  static TextStyle headlineText = const TextStyle(
      color: AppColors.kBlackColor, fontSize: 30, fontWeight: FontWeight.bold);

  static TextStyle subtitleText = const TextStyle(
    color: AppColors.kDarkGreyColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static ButtonStyle borderedButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.kPrimaryColor),
          borderRadius: BorderRadius.circular(10)),
    ),
  );
}
