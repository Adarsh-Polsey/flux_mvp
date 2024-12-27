import 'package:flutter/material.dart';
import 'package:flux_mvp/core/app_pallete.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key, required this.title, this.onPressed, this.widget,this.gradient=const LinearGradient(colors: [
            Pallete.gradient1,
            Pallete.gradient2,
          ])});
  final String title;
  final void Function()? onPressed;
  final Widget? widget;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 395,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: gradient),
      child: widget ??
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.transparentColor,
              shadowColor: Pallete.transparentColor,
              fixedSize: const Size(395, 55),
            ),
            onPressed: onPressed,
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
    );
  }
}
