import 'package:flutter/material.dart';
import 'package:telugu_bible/helper/dimension_helper.dart';
import 'package:telugu_bible/utis/colors.dart';

class AppFontStyles {
  static TextStyle smallText = TextStyle(
    fontSize: AppDimensionHelper.getHt(12),
    color: AppColors.kBlackColor,
  );

  static TextStyle MediumHeadingText = TextStyle(
    fontSize: AppDimensionHelper.getHt(18),
    color: AppColors.kBlackColor,
    fontWeight: FontWeight.bold,
  );
}
