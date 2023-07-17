import 'package:flutter/material.dart';
import '../helper/dimension_helper.dart';
import '../utis/colors.dart';

class CustomSquareButtonWidget extends StatefulWidget {
  const CustomSquareButtonWidget(
      {super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  State<CustomSquareButtonWidget> createState() =>
      _CustomSquareButtonWidgetState();
}

class _CustomSquareButtonWidgetState extends State<CustomSquareButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: AppDimensionHelper.getHt(50),
        width: AppDimensionHelper.getWd(71),
        decoration: const BoxDecoration(
            color: AppColors.kPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
