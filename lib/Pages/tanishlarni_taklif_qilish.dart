import 'package:flutter/material.dart';

class TanishlarniTaklifQilish extends StatelessWidget {
  TanishlarniTaklifQilish({super.key});

  final String inviteLink = "https://example.com/invite";

  final List<String> contacts = [
    "Ali Karimov",
    "Aziza",
    "Sardor",
    "Dilshod",
    "Malika",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invite Friends"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildInviteCard(context),
          const SizedBox(height: 16),
          const Text(
            "Contacts",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ...contacts.map((name) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  name[0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(name),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$name taklif qilindi")),
                  );
                },
                child: const Text("Invite"),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInviteCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Invite your friends to Telegram",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Share this link with your friends so they can join.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      inviteLink,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Link nusxalandi")),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Share ochildi")),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text("Share Invite Link"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
