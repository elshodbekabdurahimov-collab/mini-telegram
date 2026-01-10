import 'package:flutter/material.dart';

class YangiGuruh extends StatefulWidget {
  const YangiGuruh({super.key});

  @override
  State<YangiGuruh> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<YangiGuruh> {
  final TextEditingController _groupNameController = TextEditingController();

  final List<Map<String, dynamic>> contacts = [
    {"name": "Ali", "selected": false},
    {"name": "Vali", "selected": false},
    {"name": "Sardor", "selected": false},
    {"name": "Aziza", "selected": false},
    {"name": "Dilshod", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yangi guruh"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  child: const Icon(Icons.camera_alt, color: Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _groupNameController,
                    decoration: const InputDecoration(
                      hintText: "Guruh nomi",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Kontaktlarni tanlang",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(contact["name"][0]),
                  ),
                  title: Text(contact["name"]),
                  trailing: Checkbox(
                    value: contact["selected"],
                    onChanged: (value) {
                      setState(() {
                        contact["selected"] = value!;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final selectedUsers = contacts
                      .where((c) => c["selected"] == true)
                      .map((c) => c["name"])
                      .toList();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Guruh yaratildi: ${_groupNameController.text}\nA'zolar: $selectedUsers",
                      ),
                    ),
                  );
                },
                child: const Text("Yaratish"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
