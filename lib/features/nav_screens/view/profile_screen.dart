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
  String email = "";
  String name = "";
  String website = "";
  String phone = "";
  String company = "";
  String tagLine = "";
  String address = "";
  bool readOnly = true;

  @override
  void initState() {
    super.initState();
    // ref.read(completeProfileViewmodelProvider.notifier).getProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(completeProfileViewmodelProvider)?.isLoading ?? false;
    ref.listen(completeProfileViewmodelProvider, (prev, next) {
      next?.when(
          data: (val) {
            setState(() {
              email = val["email"];
              name = val["name"];
              website = val["website"];
              phone = val["phone"];
              company = val["company"];
              tagLine = val["tagline"];
              address = val["address"];
            });
          },
          error: (e, s) {
            notifier("Error occured, please try again", status: "error");
          },
          loading: () {});
    });
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            "Edit profile",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  const SizedBox(height: 20),
                  //Form visibility - Visible if the user is not a superuser
                  Form(
                    key: _formKey,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        // website
                        CustomField(
                          initialValue: website,
                          title: "Website: ",
                          readOnly: readOnly,
                          onSaved: (value) {
                            setState(() {
                              website = value!;
                            });
                          },
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ),
                        const SizedBox(height: 5),
// phone field
                        CustomField(
                          initialValue: phone,
                          title: "Phone no: ",
                          readOnly: readOnly,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your phone number";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              phone = value!;
                            });
                          },
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ),
                        const SizedBox(height: 5),
// company name
                        CustomField(
                          initialValue: company,
                          title: "Company name: ",
                          readOnly: readOnly,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your company name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              company = value!;
                            });
                          },
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ),
                        const SizedBox(height: 5),
// company tag line
                        CustomField(
                          initialValue: tagLine,
                          title: "Company tag line: ",
                          readOnly: readOnly,
                          onSaved: (value) {
                            setState(() {
                              tagLine = value!;
                            });
                          },
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ),
                        const SizedBox(height: 5),
// Street address
                        CustomField(
                          initialValue: phone,
                          title: "Address: ",
                          readOnly: readOnly,
                          onSaved: (value) {
                            setState(() {
                              address = value!;
                            });
                          },
                          prefixIcon: const Icon(Icons.person_2_outlined),
                        ),
                        const SizedBox(height: 10),
// Button
                        OutlinedButton(
                            onPressed: () async {
                              setState(() {
                                readOnly = !readOnly;
                              });
                              if (readOnly) {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  log("🔥To map = ${ProfileModel(company: company, website: website, phone: phone, tagline: tagLine, address: address).toMap()}");
                                  ref
                                      .read(completeProfileViewmodelProvider
                                          .notifier)
                                      .completeProfile(ProfileModel(
                                              company: company,
                                              website: website,
                                              phone: phone,
                                              tagline: tagLine,
                                              address: address)
                                          .toMap());
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
                                    (readOnly ? "Edit profile" : "Save"),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Pallete.greenColor)))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30)
                ]),
              ));
  }
}

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    this.onSaved,
    this.validator,
    this.title = "",
    this.initialValue = "",
    this.prefixIcon,
    this.readOnly = false,
  });
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String title;
  final String initialValue;
  final Widget? prefixIcon;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2.5),
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: !readOnly ? Pallete.greenColor : Pallete.greyColor),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
            readOnly: readOnly,
            style: TextStyle(
                color: !readOnly ? Pallete.greenColor : Pallete.greyColor,
                fontSize: 16),
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: title.replaceAll(":", ""),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: prefixIcon,
              prefixIconColor: Pallete.greyColor,
              labelStyle:
                  const TextStyle(color: Pallete.greyColor, fontSize: 10),
              hintStyle: const TextStyle(color: Pallete.greyColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: Pallete.greyColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Pallete.greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                  borderSide: const BorderSide(color: Pallete.greyColor)),
            ),
            validator: validator,
            onSaved: onSaved),
        const SizedBox(height: 2.5),
      ],
    );
  }
}
