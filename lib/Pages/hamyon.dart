import 'package:flutter/material.dart';

class Hamyon extends StatelessWidget {
  const Hamyon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text("Hamyon"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: const [
                  Text(
                    "Balans",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "125.50 TON",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _actionButton(Icons.send, "Yuborish"),
                _actionButton(Icons.download, "Qabul"),
                _actionButton(Icons.shopping_cart, "Sotib olish"),
              ],
            ),

            SizedBox(height: 25),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "So‘nggi tranzaksiyalar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: const [
                  _TransactionTile(
                    title: "TON yuborildi",
                    date: "10 Yanvar",
                    amount: "-5.2 TON",
                    isNegative: true,
                  ),
                  _TransactionTile(
                    title: "TON qabul qilindi",
                    date: "8 Yanvar",
                    amount: "+12 TON",
                    isNegative: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _actionButton(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool isNegative;

  const _TransactionTile({
    required this.title,
    required this.date,
    required this.amount,
    required this.isNegative,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
        isNegative ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
        child: Icon(
          isNegative ? Icons.call_made : Icons.call_received,
          color: isNegative ? Colors.red : Colors.green,
        ),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          color: isNegative ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
