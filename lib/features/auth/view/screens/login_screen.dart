import 'package:flux_mvp/core/app_pallete.dart';
import 'package:flux_mvp/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flux_mvp/shared/utils/snack_bar_message.dart';
import 'package:flux_mvp/shared/widgets/custom_button.dart';
import 'package:flux_mvp/shared/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;
    ref.listen(authViewmodelProvider, (prev, next) {
      next?.when(
          data: (user) {
            showSnackBarMessage(context, Text("Welcome! ${user.name}"));
            Navigator.pushReplacementNamed(context, '/signup');
          },
          error: (e, s) {
            showSnackBarMessage(context, Text(e.toString()));
          },
          loading: () {});
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              CustomTextfield(
                hintText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 25),
              CustomTextfield(
                hintText: "Password",
                controller: passwordController,
                isobscureText: true,
              ),
              const SizedBox(height: 30),
              GradientButton(
                title: "Sign in",
                widget: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : null,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    ref
                        .read(authViewmodelProvider.notifier)
                        .login(emailController.text, passwordController.text);
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/signup'),
                child: RichText(
                    text: const TextSpan(text: "Don't have an account? ", children: [
                  TextSpan(
                      text: "Sign up",
                      style: TextStyle(color: Pallete.gradient1))
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}