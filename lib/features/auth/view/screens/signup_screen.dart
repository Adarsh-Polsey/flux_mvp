import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/core/app_pallete.dart';
import 'package:flux_mvp/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:flux_mvp/shared/utils/toast_notifier.dart';
import 'package:flux_mvp/shared/widgets/custom_button.dart';
import 'package:flux_mvp/shared/widgets/custom_textfield.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;
    ref.listen(authViewmodelProvider, (prev, next) {
      next?.when(
          data: (user) {
            Navigator.pushReplacementNamed(context, '/login');
          },
          error: (e, s) {
            notifier(e.toString(), status: 'error');
          },
          loading: () {});
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign  Up",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 30),
              CustomTextfield(
                hintText: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 25),
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
                title: "Signup",
                widget: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : null,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(authViewmodelProvider.notifier).signup(
                        nameController.text,
                        emailController.text,
                        passwordController.text);
                  }
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/login'),
                child: RichText(
                    text: const TextSpan(
                        text: "Already have an account? ",
                        children: [
                      TextSpan(
                          text: "Sign in",
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
