import 'package:flutter/material.dart';
import 'package:telugu_admin/constants/utils/colors.utils.dart';
import 'package:telugu_admin/constants/utils/styles.utils.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
      {Key? key,
      required this.text,
      this.size = 16,
      this.color = AppColors.kBlackColor,
      this.fontWeight = FontWeight.normal})
      : super(key: key);
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppStyles.subtitleText
            .copyWith(color: color, fontSize: size, fontWeight: fontWeight));
  }
}
