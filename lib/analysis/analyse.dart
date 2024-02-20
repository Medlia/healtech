import 'package:flutter/material.dart';

class Analyze extends StatefulWidget {
  final String image;
  const Analyze({
    super.key,
    required this.image,
  });

  @override
  State<Analyze> createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            top: 8,
          ),
          child: Text(
            "Analyze Reports",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {},
                child: const Text("Analyze"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
