import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/features/nav_screens/viewmodel/complete_profile_viewmodel.dart';
import 'package:flux_mvp/shared/utils/toast_notifier.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class CreateCards extends ConsumerStatefulWidget {
  const CreateCards({super.key});

  @override
  ConsumerState<CreateCards> createState() => _CreateCardsState();
}

class _CreateCardsState extends ConsumerState<CreateCards> {
  String email = "";
  String name = "";
  String website = "";
  String phone = "";
  String company = "";
  String tagline = "";
  String address = "";
  // WidgetsToImageController to access widget
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(completeProfileViewmodelProvider.notifier).getProfileDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(completeProfileViewmodelProvider)?.isLoading ?? false;

    ref.listen(completeProfileViewmodelProvider, (prev, next) {
      next?.when(
        data: (val) {
          email = val["email"] ?? "";
          name = val["name"] ?? "";
          website = val["website"] ?? "";
          phone = val["phone"] ?? "";
          company = val["company"] ?? "";
          tagline = val["tagline"] ?? "";
          address = val["address"] ?? "";
        },
        error: (e, s) {
          notifier("Error occurred, please try again", status: "error");
        },
        loading: () {},
      );
    });
    final int templateNum = ModalRoute.of(context)!.settings.arguments as int;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('View Card'),
            ),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: WidgetsToImage(
                    controller: widgetsToImageController,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/card_$templateNum.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 8, right: 2, top: 20, bottom: 8),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name.toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        color: Color(0xffFE8B10)),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            company,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                                color: Color(0xff0071BC)),
                                          ),
                                          Text(
                                            " $tagline",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff0071BC)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.phone,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                              Text(
                                                " $phone",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.email,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                              Text(
                                                " $email",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.web,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                              Text(
                                                " $website",
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                              Text(
                                                address.length > 20
                                                    ? "${address.substring(0, 20)}..."
                                                    : address,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bytes = await widgetsToImageController.capture();
                  if (bytes != null) {
                    notifier("Image saved successfully", status: "success");
                    Share.shareXFiles(
                        [
                          XFile.fromData(bytes!,
                              name: 'My Card', mimeType: 'image/png'),
                        ],
                        subject: "Card",
                        sharePositionOrigin: Rect.fromLTWH(
                            0,
                            0,
                            MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height / 2),
                        text: '''Take a look at my card''');
                  } else {
                    notifier("Error occurred, please try again",
                        status: "error");
                  }
                },
                child: const Text("Share card"),
              ),
            ]),
          );
  }
}
