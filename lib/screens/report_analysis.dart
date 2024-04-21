import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:healtech/constants/sizes.dart';
import 'package:healtech/service/report_analysis_service.dart';
import 'package:healtech/widgets/detail_input.dart';
import 'package:healtech/widgets/report_display_card.dart';
import 'package:image_picker/image_picker.dart';

class ReportAnalysis extends StatefulWidget {
  const ReportAnalysis({Key? key}) : super(key: key);

  @override
  State<ReportAnalysis> createState() => _ReportAnalysisState();
}

class _ReportAnalysisState extends State<ReportAnalysis> {
  List<String> imageURLs = [];
  late final TextEditingController _doctorName;
  late final TextEditingController _department;

  Future<void> _selectImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        imageURLs = images.map((image) => image.path).toList();
      });
    }
  }

  Future<void> _saveDetails() async {
    String doctorName = _doctorName.text;
    String department = _department.text;

    for (String imagePath in imageURLs) {
      String imageName = DateTime.now().toString();
      Reference ref = FirebaseStorage.instance.ref().child('analyzereports/$imageName');
      UploadTask upload = ref.putFile(File(imagePath));
      await upload.whenComplete(() async {
        String imageURL = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection('analyzereports').add({
          'doctor\'s name': doctorName,
          'department': department,
          'reportURL': imageURL,
        });
      });
    }

    setState(() {
      _doctorName.clear();
      _department.clear();
      imageURLs.clear();
    });
  }

  @override
  void initState() {
    _doctorName = TextEditingController();
    _department = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    _department.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report Analysis",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                showDragHandle: true,
                enableDrag: true,
                context: context,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 25.0, 16.0, 0),
                    height: 500.0,
                    child: Column(
                      children: [
                        DetailField(
                          controller: _doctorName,
                          type: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          title: "Doctor's Name",
                          hint: 'Enter Doctor\'s name',
                        ),
                        const SizedBox(height: Sizes.sectionSpace),
                        DetailField(
                          controller: _department,
                          type: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          title: "Department Name",
                          hint: 'Enter department name',
                        ),
                        const SizedBox(height: Sizes.sectionSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    await _selectImages();
                                  },
                                  icon: const Icon(
                                    Icons.upload,
                                    size: Sizes.smallIcon,
                                  ),
                                  label: Text(
                                    'Upload reports',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.fontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FilledButton(
                              onPressed: () async {
                                await _saveDetails();
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.fontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
          padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ReportAnalysisService.reportSnapshots,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No reports found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var report = snapshot.data!.docs[index];
                        return ReportDisplayCard(report: report);
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
