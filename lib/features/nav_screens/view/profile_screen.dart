import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/core/app_pallete.dart';
import 'package:flux_mvp/features/nav_screens/models/profile_model.dart';
import 'package:flux_mvp/features/nav_screens/viewmodel/complete_profile_viewmodel.dart';
import 'package:flux_mvp/shared/utils/toast_notifier.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _taglineController = TextEditingController();
  final _addressController = TextEditingController();

  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(completeProfileViewmodelProvider.notifier).getProfileDetails();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _taglineController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(completeProfileViewmodelProvider)?.isLoading ?? false;

    ref.listen(completeProfileViewmodelProvider, (prev, next) {
      next?.when(
        data: (val) {
          _emailController.text = val["email"] ?? "";
          _nameController.text = val["name"] ?? "";
          _websiteController.text = val["website"] ?? "";
          _phoneController.text = val["phone"] ?? "";
          _companyController.text = val["company"] ?? "";
          _taglineController.text = val["tagline"] ?? "";
          _addressController.text = val["address"] ?? "";
        },
        error: (e, s) {
          notifier("Error occurred, please try again", status: "error");
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Manage Profile",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomField(
                          controller: _websiteController,
                          title: "Website",
                          readOnly: readOnly,
                          onSaved: (value) => _websiteController.text = value!,
                        ),
                        const SizedBox(height: 10),
                        CustomField(
                          controller: _phoneController,
                          title: "Phone Number",
                          readOnly: readOnly,
                          validator: (value) => value == null || value.isEmpty
                              ? "Please enter your phone number"
                              : null,
                          onSaved: (value) => _phoneController.text = value!,
                        ),
                        const SizedBox(height: 10),
                        CustomField(
                          controller: _companyController,
                          title: "Company Name",
                          readOnly: readOnly,
                          validator: (value) => value == null || value.isEmpty
                              ? "Please enter your company name"
                              : null,
                          onSaved: (value) => _companyController.text = value!,
                        ),
                        const SizedBox(height: 10),
                        CustomField(
                          controller: _taglineController,
                          title: "Tagline",
                          readOnly: readOnly,
                          onSaved: (value) => _taglineController.text = value!,
                        ),
                        const SizedBox(height: 10),
                        CustomField(
                          controller: _addressController,
                          title: "Address",
                          readOnly: readOnly,
                          onSaved: (value) => _addressController.text = value!,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              readOnly = !readOnly;
                            });
                            if (readOnly) {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final profile = ProfileModel(
                                  company: _companyController.text,
                                  website: _websiteController.text,
                                  phone: _phoneController.text,
                                  tagline: _taglineController.text,
                                  address: _addressController.text,
                                );
                                log("🔥 Profile to update: ${profile.toMap()}");
                                ref
                                    .read(completeProfileViewmodelProvider
                                        .notifier)
                                    .completeProfile(profile.toMap());
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            fixedSize: const Size(double.infinity, 50),
                          ),
                          child: Center(
                            child: Text(
                              readOnly ? "Edit Profile" : "Save",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Pallete.greenColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class CustomField extends StatefulWidget {
  const CustomField({
    super.key,
    required this.controller,
    this.onSaved,
    this.validator,
    this.title = "",
    this.readOnly = false,
  });

  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String title;
  final bool readOnly;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  // Create a FocusNode to track the focus state
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Add listener to track focus state changes
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        readOnly: widget.readOnly,
        style: TextStyle(
          color: _focusNode.hasFocus ? Pallete.greenColor : Pallete.greyColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: _focusNode.hasFocus ? Pallete.greenColor : Pallete.greyColor,
          ),
          labelText: widget.title,
          hintText: widget.title,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Pallete.greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Pallete.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Pallete.greenColor.withOpacity(0.5)),
          ),
        ),
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
