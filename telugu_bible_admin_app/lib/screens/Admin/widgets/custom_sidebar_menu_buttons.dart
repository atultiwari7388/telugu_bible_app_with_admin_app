import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/utils/colors.utils.dart';
import '../../../constants/utils/styles.utils.dart';

class SideBarMenuButtonWidget extends StatelessWidget {
  const SideBarMenuButtonWidget(
      {Key? key,
      required this.onTap,
      required this.menuName,
      required this.icon})
      : super(key: key);
  final Function() onTap;
  final String menuName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 18, right: 12, bottom: 10, left: 0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 0, right: 0, bottom: 0),
              child: FaIcon(icon, size: 18, color: AppColors.kBlackColor),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 2, right: 20, bottom: 0),
              child: Text(menuName,
                  style: AppStyles.subtitleText
                      .copyWith(color: AppColors.kBlackColor)),
            ),
          ],
        ),
      ),
    );
  }
}
