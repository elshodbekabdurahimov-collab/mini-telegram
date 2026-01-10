import 'package:flutter/material.dart';


class FiveTab extends StatefulWidget {
  const FiveTab({super.key});

  @override
  State<FiveTab> createState() => _FiveTabState();
}

class _FiveTabState extends State<FiveTab> {
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
