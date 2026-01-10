import 'package:flutter/material.dart';

class FourthTab extends StatefulWidget {
  const FourthTab({super.key});

  @override
  State<FourthTab> createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
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
