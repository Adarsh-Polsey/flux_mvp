import 'package:flutter/material.dart';
import 'package:flux_mvp/core/app_pallete.dart';
import 'package:flux_mvp/shared/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final Gradient? gradient =
      const LinearGradient(colors: [Pallete.cardColor, Pallete.cardColor]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Flux cards"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientButton(
              title: "Create cards",
              onPressed: () {},
              gradient: gradient,
            ),
            const SizedBox(height: 20),
            GradientButton(
                title: "View saved cards",
                onPressed: () {},
                gradient: gradient),
          ],
        ),
      ),
    );
  }
}
