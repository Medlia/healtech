import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healtech/constants/routes.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/service/profile_service.dart';
import 'package:healtech/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CollectionReference details =
      FirebaseFirestore.instance.collection('details');
  String gender = '';
  String age = '';
  String weight = '';
  File? avatar;

  Future<void> handleImageSelection() async {
    File? selectedImage = await ProfileService.pickImage();
    if (selectedImage != null) {
      setState(() {
        avatar = selectedImage;
      });
      await ProfileService.uploadImage(avatar);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: details.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null) {
          return const Center(
            child: Text('No user details.'),
          );
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          gender = data['gender'];
          age = data['age'];
          weight = data['weight'];
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(
                  top: Sizes.small,
                ),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  iconSize: Sizes.largerIcon,
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false).toggle();
                  },
                  icon: Icon(
                    Provider.of<ThemeProvider>(context).isDark
                        ? Icons.toggle_on
                        : Icons.toggle_off,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(settingRoute);
                  },
                  icon: const Icon(Icons.settings_rounded),
                ),
              ],
            ),
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(bottom: Sizes.sectionSpace),
                padding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 12.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          avatar != null
                              ? CircleAvatar(
                                  radius: Sizes.avatarRadius,
                                  backgroundImage: FileImage(avatar!),
                                )
                              : const CircleAvatar(
                                  radius: Sizes.avatarRadius,
                                  backgroundImage: NetworkImage(
                                    'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=',
                                  ),
                                ),
                          Positioned(
                            bottom: Sizes.tileSpace,
                            right: Sizes.tileSpace,
                            child: GestureDetector(
                              onTap: () async {
                                await handleImageSelection();
                              },
                              child: Container(
                                height: Sizes.sectionSpace,
                                width: Sizes.sectionSpace,
                                decoration: BoxDecoration(
                                  backgroundBlendMode: BlendMode.color,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(
                                      Sizes.profileBorderRadius),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: Sizes.sectionSpace,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.largeSpace),
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: Sizes.profileCardHeight,
                              width: double.infinity,
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(Sizes.medium),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Gender",
                                        style: TextStyle(
                                          fontSize: Sizes.largestFont,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        gender,
                                        style: const TextStyle(
                                          fontSize: Sizes.largeFont,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Sizes.tileSpace),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: Sizes.profileCardHeight,
                                    width: double.infinity / 2,
                                    child: Card(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(Sizes.medium),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Age",
                                              style: TextStyle(
                                                fontSize: Sizes.largestFont,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              age,
                                              style: const TextStyle(
                                                fontSize: Sizes.largeFont,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Sizes.tileSpace),
                                Expanded(
                                  child: SizedBox(
                                    height: Sizes.profileCardHeight,
                                    width: double.infinity / 2,
                                    child: Card(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(Sizes.medium),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Weight",
                                              style: TextStyle(
                                                fontSize: Sizes.largestFont,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              weight,
                                              style: const TextStyle(
                                                fontSize: Sizes.largeFont,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
