import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:healtech/widgets/image_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ImagePicker picker = ImagePicker();
  String query = '';
  late final TextEditingController _controller;
  final gemini = Gemini.instance;
  String? searchedText, _finishReason;

  List<Uint8List>? images;

  String? get finishReason => _finishReason;

  set finishReason(String? set) {
    if (set != _finishReason) {
      setState(() => _finishReason = set);
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            "Chat",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
        child: SearchBar(
          controller: _controller,
          hintText: "Enter a prompt here",
          trailing: [
            IconButton(
              onPressed: () {
                picker.pickMultiImage().then(
                  (value) async {
                    final imagesBytes = <Uint8List>[];
                    for (final file in value) {
                      imagesBytes.add(await file.readAsBytes());
                    }

                    if (imagesBytes.isNotEmpty) {
                      setState(() {
                        images = imagesBytes;
                      });
                    }
                  },
                );
              },
              icon: const Icon(
                Icons.image_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    query = _controller.text;
                  });
                  searchedText = _controller.text;
                  _controller.clear();
                  gemini
                      .streamGenerateContent(searchedText!, images: images)
                      .listen(
                    (value) {
                      setState(() {
                        images = null;
                      });
                      if (value.finishReason != 'STOP') {
                        finishReason = 'Finish reason is `RECITATION`';
                      }
                    },
                  ).onError(
                    (e) {
                      log('streamGenerateContent error', error: e);
                    },
                  );
                }
              },
              icon: const Icon(
                Icons.send_rounded,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (images != null)
                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  alignment: Alignment.center,
                  child: Card(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ImageCard(
                        bytes: images!.elementAt(index),
                      ),
                      itemCount: images!.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal,
                  ),
                  child: GeminiResponseTypeView(
                    builder: (context, child, response, loading) {
                      if (loading) {
                        return Center(
                          child: Lottie.asset('assets/ai.json'),
                        );
                      }

                      if (response != null) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                query,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                response,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      } else {
                        return const Text('Search something!');
                      }
                    },
                  ),
                ),
              ),
              if (finishReason != null) Text(finishReason!),
            ],
          ),
        ),
      ),
    );
  }
}
