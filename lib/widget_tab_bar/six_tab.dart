import 'package:flutter/material.dart';

class SixTab extends StatefulWidget {
  const SixTab({super.key});

  @override
  State<SixTab> createState() => _SixTabState();
}

class _SixTabState extends State<SixTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Barchasi")
          ],
        ),
      ),
    );
  }
}
