import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telegram/Pages/chaqiruvlar.dart';
import 'package:telegram/Pages/hamyon.dart';
import 'package:telegram/Pages/kontaklar.dart';
import 'package:telegram/Pages/profile.dart';
import 'package:telegram/Pages/saqlangan_xabarlar.dart';
import 'package:telegram/Pages/tanishlarni_taklif_qilish.dart';
import 'package:telegram/Pages/telegram_funksiyalari.dart';
import 'package:telegram/Pages/yangi_guruh.dart';
import 'package:telegram/chat_page.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    addUserToFirestore(widget.user);
  }

  void addUserToFirestore(User user) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'uid': user.uid,
        'email': user.email,
        'name': user.email!.split('@')[0],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Telegram"),
        backgroundColor: Colors.blue,
      ),
      drawer: StreamBuilder<DocumentSnapshot>(
        // hozirgi foydalanuvchining documentini olamiz
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Drawer(child: Center(child: CircularProgressIndicator()));
          }
          final userData = snapshot.data!;
          final name = userData['name'];
          final email = userData['email'];

          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  accountName: Text(name, style: TextStyle(fontSize: 18)),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      name[0].toUpperCase(),
                      style: TextStyle(fontSize: 30, color: Colors.blue),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text("Profilim"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()
                        )
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet_outlined),
                  title: Text("Hamyon"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Hamyon()
                        )
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text("Yangi guruh"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YangiGuruh())
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_outline_outlined),
                  title: Text("Kontaklar"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Kontaklar())
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.phone_outlined),
                  title: Text("Chaqiruvlar"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chaqiruvlar())
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark_border_rounded),
                  title: Text("Saqlangan xabarlar"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaqlanganXabarlar())
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text("Sozlamalar"),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.person_add_outlined),
                  title: Text("Tanishlarni taklif qilish"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TanishlarniTaklifQilish())
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.question_mark_outlined),
                  title: Text("Telegram funksiyalari"),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TelegramFunksiyalari())
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final users = snapshot.data!.docs.where((doc) => doc['uid'] != widget.user.uid).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      user['name'][0].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(user['email']),
                  trailing: Icon(Icons.message, color: Colors.blue),
                  onTap: () async {
                    final chatId = await createChat(widget.user.uid, user['uid']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatPage(chatId: chatId, currentUser: widget.user)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<String> createChat(String user1Id, String user2Id) async {
    final chatId = user1Id + '_' + user2Id;
    final chatRef = FirebaseFirestore.instance.collection('chats').doc(chatId);
    final doc = await chatRef.get();
    if (!doc.exists) {
      await chatRef.set({
        'users': [user1Id, user2Id],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    return chatId;
  }
}
