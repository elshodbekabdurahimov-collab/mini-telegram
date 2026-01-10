import 'package:flutter/material.dart';

class Kontaklar extends StatelessWidget {
  Kontaklar({super.key});

  final List<Map<String, String>> contacts = [
    {
      "name": "Ali Karimov",
      "status": "online",
    },
    {
      "name": "Dilshodbek",
      "status": "last seen recently",
    },
    {
      "name": "Aziza",
      "status": "online",
    },
    {
      "name": "Sardor",
      "status": "last seen yesterday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          _buildTopItem(Icons.group, "New Group"),
          _buildTopItem(Icons.person_add, "New Contact"),
          const Divider(),

          ...contacts.map((contact) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  contact["name"]![0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(contact["name"]!),
              subtitle: Text(
                contact["status"]!,
                style: TextStyle(
                  color: contact["status"] == "online"
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
              onTap: () {
                // chat page ochish
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTopItem(IconData icon, String title) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      onTap: () {},
    );
  }
}
