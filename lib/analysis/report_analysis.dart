import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healtech/analysis/analyse.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportAnalysis extends StatefulWidget {
  const ReportAnalysis({super.key});

  @override
  State<ReportAnalysis> createState() => _ReportAnalysisState();
}

class _ReportAnalysisState extends State<ReportAnalysis> {
  late final CollectionReference reportCollection;
  File? report;

  Future<List<File>?> pickFiles() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      List<File> files = [];
      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        files.add(file);
      }
      return files;
    } else {
      return null;
    }
  }

  Future uploadFile(File file, String folder) async {
    try {
      final fileName = path.basename(file.path);
      final destination = '$folder/$fileName';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(destination);
      final UploadTask uploadTask = storageReference.putFile(file);
      final TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveReports(File report) async {
    List reportURL = await uploadFile(report, 'reportAnalysis');

    List<Future> futures = [];
    futures.add(
      reportCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('entries')
          .add(
        {'report': reportURL},
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    reportCollection = FirebaseFirestore.instance.collection('analysis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Report Analysis",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (BuildContext context) {
                  return BottomSheet(
                    onClosing: saveReports as VoidCallback,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Upload reports",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await pickFiles();
                              },
                              icon: const Icon(Icons.upload_rounded),
                              label: const Text(
                                "Upload",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: reportCollection
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('entries')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.data == null ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No report added yet.'),
                      );
                    }
                    var allReports = snapshot.data!.docs
                        .map((report) => report.data() as Map<String, dynamic>)
                        .toList();
                    return ListView.builder(
                      itemCount: allReports.length,
                      itemBuilder: (context, index) {
                        var reportData = allReports[index];
                        var reportImages = reportData['report'] as List<String>;
                        return Column(
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: reportImages.length,
                              itemBuilder: (context, imageIndex) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Analyze(
                                          image: reportImages[imageIndex],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: Card(
                                      child: Image.network(
                                        reportImages[imageIndex],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
