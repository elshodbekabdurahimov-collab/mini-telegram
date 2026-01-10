import 'package:flutter/material.dart';

class Chaqiruvlar extends StatelessWidget {
  Chaqiruvlar({super.key});

  final List<Map<String, dynamic>> calls = [
    {
      "name": "Ali Karimov",
      "time": "Today, 14:30",
      "incoming": true,
      "missed": false,
      "video": false,
    },
    {
      "name": "Aziza",
      "time": "Yesterday, 21:10",
      "incoming": false,
      "missed": false,
      "video": true,
    },
    {
      "name": "Sardor",
      "time": "Yesterday, 09:45",
      "incoming": true,
      "missed": true,
      "video": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calls"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                call["name"][0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(call["name"]),
            subtitle: Row(
              children: [
                Icon(
                  call["incoming"]
                      ? Icons.call_received
                      : Icons.call_made,
                  size: 16,
                  color: call["missed"] ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 6),
                Text(
                  call["time"],
                  style: TextStyle(
                    color: call["missed"] ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              call["video"] ? Icons.videocam : Icons.call,
              color: Colors.blue,
            ),
            onTap: () {
              // Call details page
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_call),
      ),
    );
  }
}
